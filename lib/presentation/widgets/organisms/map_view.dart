import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';

class MapView extends StatefulWidget {
  final MapController? mapController;
  final List<LatLng> route;
  final LatLng? destinationLocation;
  final LatLng? startLocation;
  final LatLng? currentPosition;

  const MapView({
    super.key,
    this.mapController,
    this.route = const [],
    this.destinationLocation,
    this.startLocation,
    this.currentPosition,
  });

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late final MapController _internalMapController;

  @override
  void initState() {
    super.initState();
    _internalMapController = widget.mapController ?? MapController();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _internalMapController,
      options: MapOptions(
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
        ),
        initialCenter: widget.currentPosition ??
            const LatLng(
              18.921838797345576,
              -99.23416631442007,
            ),
        initialZoom: 16,
        minZoom: 0,
        maxZoom: 100,
        onMapReady: _onMapReady,
      ),
      children: [
        _buildTileLayer(),
        if (widget.startLocation == null) _buildCurrentLocationLayer(),
        if (widget.route.isNotEmpty) _buildRouteLayer(),
        if (widget.startLocation != null) _buildStartMarker(),
        if (widget.destinationLocation != null) _buildDestinationMarker(),
      ],
    );
  }

  void _onMapReady() {
    if (widget.currentPosition != null) {
      _internalMapController.move(widget.currentPosition!, 16);
    }
  }

  TileLayer _buildTileLayer() {
    return TileLayer(
      urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
    );
  }

  CurrentLocationLayer _buildCurrentLocationLayer() {
    return CurrentLocationLayer(
      style: const LocationMarkerStyle(
        markerSize: Size(32, 32),
        markerDirection: MarkerDirection.heading,
      ),
    );
  }

  PolylineLayer _buildRouteLayer() {
    final theme = Theme.of(context);
    return PolylineLayer(
      polylines: [
        Polyline(points: widget.route, strokeWidth: 6, color: theme.focusColor),
      ],
    );
  }

  MarkerLayer _buildStartMarker() {
    final theme = Theme.of(context);
    return MarkerLayer(
      markers: [
        Marker(
          point: widget.startLocation!,
          width: 40,
          height: 40,
          child: Icon(Icons.radio_button_checked,
              color: theme.secondaryHeaderColor, size: 24),
        ),
      ],
    );
  }

  MarkerLayer _buildDestinationMarker() {
    final theme = Theme.of(context);
    return MarkerLayer(
      markers: [
        Marker(
          point: widget.destinationLocation!,
          child: Icon(Icons.location_on, color: theme.primaryColor, size: 32),
        ),
      ],
    );
  }
}
