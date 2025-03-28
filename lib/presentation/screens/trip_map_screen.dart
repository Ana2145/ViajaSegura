import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:viaja_segura_movil/presentation/widgets/organisms/map_view.dart';

class TripMapScreen extends StatefulWidget {
  final String start;
  final String destination;
  final LatLng? startPosition;

  const TripMapScreen({
    super.key,
    required this.start,
    required this.destination,
    this.startPosition,
  });

  @override
  State<TripMapScreen> createState() => _TripMapScreenState();
}

class _TripMapScreenState extends State<TripMapScreen> {
  final MapController _mapController = MapController();
  late List<LatLng> _route = [];
  LatLng? _startLocation;
  LatLng? _destinationLocation;
  bool _isLoading = true;
  final bool _mapInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateRoute();
    });
  }

  Future<LatLng> _getLocationCoordinates(String location) async {
    if (location == widget.start && widget.startPosition != null) {
      return widget.startPosition!;
    }

    final url = Uri.parse(
        'https://nominatim.openstreetmap.org/search?q=$location&format=json&limit=1');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        return LatLng(
          double.parse(data[0]['lat']),
          double.parse(data[0]['lon']),
        );
      }
    }
    throw Exception('Ubicación no encontrada');
  }

  Future<void> _calculateRoute() async {
    try {
      _startLocation = await _getLocationCoordinates(widget.start);
      _destinationLocation = await _getLocationCoordinates(widget.destination);
      await _fetchDirections();

      if (!mounted) return;
      setState(() => _isLoading = false);

      if (!_mapInitialized) {
        await Future.delayed(const Duration(milliseconds: 100));
      }
      _moveToRoute();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al obtener la ruta: $e'),
          backgroundColor: Colors.red,
        ),
      );
      Navigator.pop(context);
    }
  }

  Future<void> _fetchDirections() async {
    if (_startLocation == null || _destinationLocation == null) return;

    final url = Uri.parse("https://router.project-osrm.org/route/v1/driving/"
        "${_startLocation!.longitude},${_startLocation!.latitude};"
        "${_destinationLocation!.longitude},${_destinationLocation!.latitude}"
        "?overview=full&geometries=polyline");

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final geometry = data['routes'][0]['geometry'];
      _decodePolyline(geometry);
    } else {
      throw Exception('Error al obtener la ruta');
    }
  }

  void _decodePolyline(String encodedPolyline) {
    final PolylinePoints polylinePoints = PolylinePoints();
    final List<PointLatLng> decodedPoints =
        polylinePoints.decodePolyline(encodedPolyline);

    setState(() {
      _route = decodedPoints
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();
    });
  }

  void _moveToRoute() {
    if (_route.isEmpty) return;

    double latSum = 0;
    double lonSum = 0;
    for (final point in _route) {
      latSum += point.latitude;
      lonSum += point.longitude;
    }

    final center = LatLng(latSum / _route.length, lonSum / _route.length);
    _mapController.move(center, 12);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ruta del viaje'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : MapView(
              mapController: _mapController,
              route: _route,
              startLocation: _startLocation,
              destinationLocation: _destinationLocation,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _moveToRoute,
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }
}
