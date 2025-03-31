import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math' as math;

import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:viaja_segura_movil/presentation/widgets/atoms/location_fab.dart';
import 'package:viaja_segura_movil/presentation/widgets/molecules/top_bar.dart';
import 'package:viaja_segura_movil/presentation/widgets/organisms/drivers_list.dart';
import 'package:viaja_segura_movil/presentation/widgets/organisms/map_view.dart';
import 'package:viaja_segura_movil/presentation/widgets/organisms/text_field_button.dart';

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

    final bounds = _calculateBounds(_route);
    final zoom = _calculateZoomLevel(bounds);

    final center = LatLng(
      (bounds.south + bounds.north) / 2 - 0.02,
      (bounds.west + bounds.east) / 2,
    );

    _mapController.move(center, zoom);
  }

  LatLngBounds _calculateBounds(List<LatLng> points) {
    double? minLat, maxLat, minLng, maxLng;

    for (final point in points) {
      minLat =
          minLat == null ? point.latitude : math.min(minLat, point.latitude);
      maxLat =
          maxLat == null ? point.latitude : math.max(maxLat, point.latitude);
      minLng =
          minLng == null ? point.longitude : math.min(minLng, point.longitude);
      maxLng =
          maxLng == null ? point.longitude : math.max(maxLng, point.longitude);
    }

    return LatLngBounds(
      LatLng(minLat!, minLng!),
      LatLng(maxLat!, maxLng!),
    );
  }

  double _calculateZoomLevel(LatLngBounds bounds) {
    const double minZoom = 1.0;
    const double maxZoom = 100.0;
    const double padding = 1.75;

    final distance = _calculateDistance(
      bounds.southWest.latitude,
      bounds.southWest.longitude,
      bounds.northEast.latitude,
      bounds.northEast.longitude,
    );

    double zoomLevel = 16 - math.log(distance * padding) / math.ln2;

    return zoomLevel.clamp(minZoom, maxZoom);
  }

  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const r = 6371;
    final dLat = _toRadians(lat2 - lat1);
    final dLon = _toRadians(lon2 - lon1);
    final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_toRadians(lat1)) *
            math.cos(_toRadians(lat2)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);
    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return r * c;
  }

  double _toRadians(double degree) {
    return degree * math.pi / 180;
  }

  void _goBack() => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const TopBar(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                MapView(
                  mapController: _mapController,
                  route: _route,
                  startLocation: _startLocation,
                  destinationLocation: _destinationLocation,
                ),
                Positioned(
                  top: 96,
                  right: 16,
                  left: 16,
                  child: Column(
                    children: [
                      TextFieldButton(
                        icon: Icons.location_on,
                        text: widget.start,
                        onPressed: _goBack,
                      ),
                      const SizedBox(height: 8),
                      TextFieldButton(
                        icon: Icons.flag,
                        text: widget.destination,
                        onPressed: _goBack,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: LocationFab(onPressed: _moveToRoute),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: const DriversList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
