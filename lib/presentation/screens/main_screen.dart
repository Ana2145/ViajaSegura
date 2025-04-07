import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:viaja_segura_movil/core/services/map_location_services.dart';
import 'package:viaja_segura_movil/presentation/screens/trip_selection_screen.dart';
import 'package:viaja_segura_movil/presentation/widgets/atoms/location_fab.dart';
import 'package:viaja_segura_movil/presentation/widgets/molecules/top_bar.dart';
import 'package:viaja_segura_movil/presentation/widgets/organisms/custom_drawer.dart';
import 'package:viaja_segura_movil/presentation/widgets/templates/map_bottom_panel.dart';
import 'package:viaja_segura_movil/presentation/widgets/organisms/map_view.dart';
import 'package:viaja_segura_movil/presentation/widgets/organisms/text_field_button.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final MapController _mapController = MapController();
  final MapLocationServices _locationService = MapLocationServices();
  LatLng? _currentPosition;
  String? _currentAddress;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initLocationService();
  }

  Future<void> _initLocationService() async {
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

    await _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    final locationData = await _locationService.getCurrentLocation();
    if (locationData != null &&
        locationData.latitude != null &&
        locationData.longitude != null) {
      await _updatePosition(locationData);
    } else {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _updatePosition(LocationData locationData) async {
    final newPosition = LatLng(locationData.latitude!, locationData.longitude!);
    final address = await _locationService.getAddressFromLatLng(
        newPosition.latitude, newPosition.longitude);

    setState(() {
      _currentPosition = newPosition;
      _currentAddress = address;
      _isLoading = false;
    });
  }

  void _navigateToTripSelection(BuildContext context) {
    if (_currentAddress == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TripSelectionScreen(
          initialAddress: _currentAddress!,
          initialPosition: _currentPosition,
        ),
      ),
    );
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
      drawer: const CustomDrawer(),
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
                child: Column(
                  children: [
                    TextFieldButton(
                      icon: Icons.search,
                      text: '¿A dónde quieres ir?',
                      onPressed: () => _navigateToTripSelection(context),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 144,
              right: 16,
              child: LocationFab(onPressed: _resetMap),
            ),
          ]
        ],
      ),
    );
  }
}
