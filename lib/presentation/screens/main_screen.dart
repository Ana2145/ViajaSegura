import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:viaja_segura_movil/presentation/widgets/molecules/top_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final MapController mapController = MapController();
  final Location _location = Location();
  final TextEditingController _searchController = TextEditingController();
  bool isLoading = true;
  LatLng? _currentLocation;
  LatLng? _destinationLocation;
  List<LatLng> _route = [];

  @override
  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<void> fetchCoordinatesPoint(String location) async {
    final url = Uri.parse(
        'https://nominatim.openstreetmap.org/search?q=$location&format=json&limit=1');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        final lat = double.parse(data[0]['lat']);
        final lon = double.parse(data[0]['lon']);
        setState(() => _destinationLocation = LatLng(lat, lon));
        await fetchRoute();
      } else {
        errorMessage('No se ha encontrado la ubicación');
      }
    } else {
      errorMessage('Error al obtener la ubicación');
    }
  }

  Future<void> fetchRoute() async {
    if (_currentLocation == null || _destinationLocation == null) return;
    final url = Uri.parse("https://router.project-osrm.org/route/v1/driving/"
        "${_currentLocation!.longitude},${_currentLocation!.latitude};"
        "${_destinationLocation!.longitude},${_destinationLocation!.latitude}"
        "?overview=full&geometries=polyline");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final geometry = data['routes'][0]['geometry'];
      _decodePolyline(geometry);
    } else {
      errorMessage('Error al obtener la ruta');
    }
  }

  void _decodePolyline(String encodePolyline) {
    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPoints =
    polylinePoints.decodePolyline(encodePolyline);

    setState(() {
      _route = decodedPoints
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();
    });
  }

  void errorMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<void> _initializeLocation() async {
    if (!await _checkTheRequestPermissions()) return;

    _location.onLocationChanged.listen((LocationData locationData) {
      if (locationData.latitude != null && locationData.longitude != null) {
        setState(() {
          _currentLocation = LatLng(
            locationData.latitude!,
            locationData.longitude!,
          );
          isLoading = false;
        });
      }
    });
  }

  Future<bool> _checkTheRequestPermissions() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) return false;
    }

    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return false;
    }
    return true;
  }

  Future<void> _userLocation() async {
    if (_currentLocation != null) {
      mapController.move(_currentLocation!, 16);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No se ha podido obtener tu ubicación'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const TopBar(),
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: const MapOptions(
              initialCenter: LatLng(18.921361917967296, -99.23316953776555),
              initialZoom: 16,
              minZoom: 0,
              maxZoom: 100,
            ),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              ),
              CurrentLocationLayer(
                style: const LocationMarkerStyle(
                  marker: DefaultLocationMarker(
                    child: Icon(Icons.location_on_outlined),
                  ),
                  markerSize: Size(50, 50),
                  markerDirection: MarkerDirection.heading,
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: _userLocation,
        backgroundColor: Theme.of(context).canvasColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(64)),
        child: Icon(Icons.my_location, color: Theme.of(context).primaryColor),
      ),
    );
  }
}
