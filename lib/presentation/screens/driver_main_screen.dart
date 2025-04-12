import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:viaja_segura_movil/data/services/map_location_services.dart';
import 'package:viaja_segura_movil/presentation/widgets/atoms/custom_button.dart';
import 'package:viaja_segura_movil/presentation/widgets/atoms/location_fab.dart';
import 'package:viaja_segura_movil/presentation/widgets/molecules/top_bar.dart';
import 'package:viaja_segura_movil/presentation/widgets/organisms/driver_drawer.dart';
import 'package:viaja_segura_movil/presentation/widgets/organisms/map_view.dart';
import 'package:viaja_segura_movil/presentation/widgets/templates/map_bottom_panel.dart';

class DriverMainScreen extends StatefulWidget {
  const DriverMainScreen({super.key});

  @override
  State<DriverMainScreen> createState() => _DriverMainScreenState();
}

class _DriverMainScreenState extends State<DriverMainScreen> {
  final MapController _mapController = MapController();
  final MapLocationServices _locationService = MapLocationServices();
  LatLng? _currentPosition;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    final serviceEnabled = await _locationService.checkAndRequestService();
    if (!serviceEnabled) {
      setState(() => _isLoading = false);
      return;
    }

    final permissionGranted =
        await _locationService.checkAndRequestPermission();
    if (!permissionGranted) {
      setState(() => _isLoading = false);
      return;
    }

    final locationData = await _locationService.getCurrentLocation();
    if (locationData != null && locationData.longitude != null) {
      setState(() {
        _currentPosition =
            LatLng(locationData.latitude!, locationData.longitude!);
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
    }
  }

  void _resetMap() {
    if (_currentPosition != null) {
      _mapController.move(_currentPosition!, 16);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawerEnableOpenDragGesture: false,
      appBar: const TopBar(),
      drawer: const DriverDrawer(),
      body: Stack(
        children: [
          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else
            MapView(
              mapController: _mapController,
              currentPosition: _currentPosition,
            ),
          if (!_isLoading) ...[
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: MapBottomPanel(
                child: CustomButton(
                  text: 'Listo para viajar',
                  onPressed: () {},
                ),
              ),
            ),
            Positioned(
              bottom: 144,
              right: 16,
              child: LocationFab(onPressed: _resetMap),
            ),
          ],
        ],
      ),
    );
  }
}
