import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:viaja_segura_movil/presentation/widgets/molecules/top_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final MapController mapController = MapController();
  final GeolocatorPlatform _geolocator = GeolocatorPlatform.instance;
  final TextEditingController _searchController = TextEditingController();

  bool isLoading = true;
  LatLng? _currentLocation;
  LatLng? _destinationLocation;
  List<LatLng> _route = [];

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  /// Obtiene las coordenadas de un punto a partir de una búsqueda en texto
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

        mapController.move(_destinationLocation!, 16); // Centrar en destino
        await fetchRoute();
      } else {
        errorMessage('No se ha encontrado la ubicación');
      }
    } else {
      errorMessage('Error al obtener la ubicación');
    }
  }

  /// Obtiene la ruta entre la ubicación actual y el destino
  Future<void> fetchRoute() async {
    if (_currentLocation == null || _destinationLocation == null) return;

    final url = Uri.parse(
        "https://router.project-osrm.org/route/v1/driving/"
            "${_currentLocation!.longitude},${_currentLocation!.latitude};"
            "${_destinationLocation!.longitude},${_destinationLocation!.latitude}?overview=full&geometries=polyline");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final geometry = data['routes'][0]['geometry'];
      _decodePolyline(geometry);
    } else {
      errorMessage('Error al obtener la ruta');
    }
  }

  /// Decodifica la polilínea de OpenStreetMap y la convierte en lista de coordenadas
  void _decodePolyline(String encodePolyline) {
    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPoints = polylinePoints.decodePolyline(encodePolyline);

    setState(() {
      _route = decodedPoints
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();
    });
  }

  /// Muestra un mensaje de error en un SnackBar
  void errorMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<void> _initializeLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verificar si el servicio de ubicación está habilitado
    serviceEnabled = await _geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      errorMessage('El servicio de ubicación no está habilitado.');
      return;
    }

    // Verificar si se tienen permisos de ubicación
    permission = await _geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        errorMessage('Permiso de ubicación denegado.');
        return;
      }
    }

    try {
      // Obtener la ubicación actual
      Position position = await _geolocator.getCurrentPosition();
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        isLoading = false;
      });

      // Escuchar cambios en la ubicación del usuario
      _geolocator.getPositionStream().listen((Position position) {
        setState(() {
          _currentLocation = LatLng(position.latitude, position.longitude);
        });
      });
    } catch (e) {
      errorMessage("Error al obtener la ubicación: $e");
    }
  }

  /// Centra el mapa en la ubicación actual del usuario
  Future<void> _userLocation() async {
    if (_currentLocation != null) {
      mapController.move(_currentLocation!, 16);
    } else {
      errorMessage('No se ha podido obtener tu ubicación');
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
              if (_route.isNotEmpty)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: _route,
                      color: Colors.blue,
                      strokeWidth: 5.0,
                    ),
                  ],
                ),
              if (_destinationLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _destinationLocation!,
                      width: 40,
                      height: 40,
                      child: const Icon(Icons.location_pin, color: Colors.red, size: 40),
                    ),
                  ],
                ),
            ],
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
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
