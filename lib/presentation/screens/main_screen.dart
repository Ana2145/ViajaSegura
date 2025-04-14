import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viaja_segura_movil/data/cubits/ride_state/ride_cubit.dart';
import 'package:viaja_segura_movil/data/cubits/ride_state/ride_state.dart';
import 'package:viaja_segura_movil/data/services/map_location_services.dart';
import 'package:viaja_segura_movil/presentation/screens/trip_map_screen.dart';
import 'package:viaja_segura_movil/presentation/screens/trip_selection_screen.dart';
import 'package:viaja_segura_movil/presentation/widgets/atoms/location_fab.dart';
import 'package:viaja_segura_movil/presentation/widgets/molecules/top_bar.dart';
import 'package:viaja_segura_movil/presentation/widgets/organisms/custom_drawer.dart';
import 'package:viaja_segura_movil/presentation/widgets/organisms/location_error.dart';
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
  String? _locationError;

  @override
  void initState() {
    super.initState();
    _initLocationService();
    _getCurrentRideStatus();
  }

  Future<void> _getCurrentRideStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('id');
    if (!mounted) return;
    context.read<RideCubit>().getRidesByPassengerId(id!);
  }

  Future<void> _initLocationService() async {
    final serviceEnabled = await _locationService.checkAndRequestService();
    if (mounted && !serviceEnabled) {
      setState(() {
        _isLoading = false;
        _locationError = 'El servicio de ubicación está desactivado.';
      });
      return;
    }

    final permissionGranted =
        await _locationService.checkAndRequestPermission();
    if (mounted && !permissionGranted) {
      setState(() {
        _isLoading = false;
        _locationError = 'Permiso de ubicación denegado.';
      });
      return;
    }

    await _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      final locationData = await _locationService.getCurrentLocation();
      if (mounted &&
          locationData != null &&
          locationData.latitude != null &&
          locationData.longitude != null) {
        await _updatePosition(locationData);
      } else {
        if (mounted) {
          setState(() {
            _isLoading = false;
            _locationError = 'No se pudo obtener la ubicación actual.';
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _locationError = 'Ocurrió un error al obtener la ubicación.';
        });
      }
    }
  }

  Future<void> _updatePosition(LocationData locationData) async {
    final newPosition = LatLng(locationData.latitude!, locationData.longitude!);
    final address = await _locationService.getAddressFromLatLng(
        newPosition.latitude, newPosition.longitude);

    if (mounted) {
      setState(() {
        _currentPosition = newPosition;
        _currentAddress = address;
        _isLoading = false;
      });
    }
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
    if (_currentPosition != null) _mapController.move(_currentPosition!, 16);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RideCubit, RideState>(
      listener: (context, state) {
        if (state is RideLoaded && state.rides.isNotEmpty) {
          final lastRide = state.rides.last;
          if (lastRide.status.name == 'pending') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => TripMapScreen(
                  startPosition: LatLng(
                    lastRide.originLat,
                    lastRide.originLng
                  ),
                  destinationPosition: LatLng(
                    lastRide.destinationLat,
                    lastRide.destinationLng,
                  ),
                ),
              ),
            );
          }
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        drawerEnableOpenDragGesture: false,
        appBar: const TopBar(),
        drawer: const CustomDrawer(),
        body: Stack(
          children: [
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else if (_locationError != null)
              LocationError(
                message: _locationError!,
                onRetry: () {
                  setState(() {
                    _isLoading = true;
                    _locationError = null;
                  });
                  _initLocationService();
                },
              )
            else
              MapView(
                mapController: _mapController,
                currentPosition: _currentPosition,
              ),
            if (!_isLoading && _locationError == null) ...[
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
      ),
    );
  }
}
