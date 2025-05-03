import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viaja_segura_movil/data/cubits/driver/driver.availability.cubit.dart';
import 'package:viaja_segura_movil/data/services/map_location_services.dart';
import 'package:viaja_segura_movil/data/repositories/driver_repository.dart';
import 'package:viaja_segura_movil/presentation/widgets/atoms/location_fab.dart';
import 'package:viaja_segura_movil/presentation/widgets/molecules/top_bar.dart';
import 'package:viaja_segura_movil/presentation/widgets/organisms/driver_availability_button.dart';
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

  DriverAvailabilityCubit? _availabilityCubit;

  @override
  void initState() {
    super.initState();
    _initLocation();
    _initCubit();
  }

  Future<void> _initCubit() async {
    final prefs = await SharedPreferences.getInstance();
    final driverId = prefs.getInt('driverId') ?? 0;
    setState(() {
      _availabilityCubit = DriverAvailabilityCubit(
        driverRepository: DriverRepository(),
        driverId: driverId,
      );
    });
    _availabilityCubit!.fetchAvailability();
  }

  Future<void> _initLocation() async {
    final serviceEnabled = await _locationService.checkAndRequestService();
    if (!serviceEnabled) return setState(() => _isLoading = false);

    final permissionGranted =
        await _locationService.checkAndRequestPermission();
    if (!permissionGranted) return setState(() => _isLoading = false);

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
    if (_availabilityCubit == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return BlocProvider.value(
      value: _availabilityCubit!,
      child: Scaffold(
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
                  child: DriverAvailabilityButton(),
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
      ),
    );
  }
}
