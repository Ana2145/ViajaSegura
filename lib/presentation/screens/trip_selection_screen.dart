import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:viaja_segura_movil/presentation/screens/trip_map_screen.dart';
import 'package:http/http.dart' as http;
import 'package:viaja_segura_movil/presentation/widgets/atoms/custom_button.dart';
import 'dart:convert';
import 'dart:async';
import 'package:viaja_segura_movil/presentation/widgets/organisms/location_text_field.dart';
import 'package:viaja_segura_movil/presentation/widgets/atoms/swap_locations_button.dart';
import 'package:viaja_segura_movil/presentation/widgets/organisms/suggestions_list.dart';

class TripSelectionScreen extends StatefulWidget {
  final String initialAddress;
  final LatLng? initialPosition;

  const TripSelectionScreen({
    super.key,
    required this.initialAddress,
    this.initialPosition,
  });

  @override
  State<TripSelectionScreen> createState() => _TripSelectionScreenState();
}

class _TripSelectionScreenState extends State<TripSelectionScreen> {
  late final TextEditingController _startController;
  final TextEditingController _destinationController = TextEditingController();
  List<String> _startSuggestions = [];
  List<String> _destinationSuggestions = [];
  Timer? _debounce;
  bool _loadingStart = false;
  bool _loadingDestination = false;
  bool _showStartSuggestions = false;
  bool _showDestinationSuggestions = false;

  @override
  void initState() {
    super.initState();
    _startController = TextEditingController(text: widget.initialAddress);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onLocationChanged(String value, bool isStart) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    setState(() {
      if (isStart) {
        _loadingStart = true;
        _showStartSuggestions = true;
      } else {
        _loadingDestination = true;
        _showDestinationSuggestions = true;
      }
    });

    _debounce = Timer(const Duration(milliseconds: 500), () {
      _fetchSuggestions(value, isStart);
    });
  }

  Future<void> _fetchSuggestions(String query, bool isStart) async {
    if (query.isEmpty) {
      setState(() {
        if (isStart) {
          _startSuggestions = [];
          _loadingStart = false;
          _showStartSuggestions = false;
        } else {
          _destinationSuggestions = [];
          _loadingDestination = false;
          _showDestinationSuggestions = false;
        }
      });
      return;
    }

    final url = Uri.parse(
        'https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=5');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        setState(() {
          if (isStart) {
            _startSuggestions = data.map<String>((item) => item['display_name'] as String).toList();
            _loadingStart = false;
          } else {
            _destinationSuggestions = data.map<String>((item) => item['display_name'] as String).toList();
            _loadingDestination = false;
          }
        });
      }
    } catch (e) {
      setState(() {
        if (isStart) {
          _loadingStart = false;
        } else {
          _loadingDestination = false;
        }
      });
    }
  }

  void _swapLocations() {
    if (_startController.text.isEmpty || _destinationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ingresa inicio y destino para intercambiar'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    final temp = _startController.text;
    setState(() {
      _startController.text = _destinationController.text;
      _destinationController.text = temp;

      final tempSuggestions = _startSuggestions;
      _startSuggestions = _destinationSuggestions;
      _destinationSuggestions = tempSuggestions;

      final tempShow = _showStartSuggestions;
      _showStartSuggestions = _showDestinationSuggestions;
      _showDestinationSuggestions = tempShow;
    });
  }

  void _navigateToTripMap() {
    if (_startController.text.isEmpty || _destinationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor ingresa inicio y destino'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TripMapScreen(
          start: _startController.text,
          destination: _destinationController.text,
          startPosition: _startController.text == widget.initialAddress
              ? widget.initialPosition
              : null,
        ),
      ),
    );
  }

  void _clearStartInput() => _startController.clear();
  void _clearDestinationInput() => _destinationController.clear();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitar viaje'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LocationTextField(
              controller: _startController,
              label: 'Inicio del viaje',
              prefixIcon: const Icon(Icons.location_on),
              onClear: _clearStartInput,
              isLoading: _loadingStart,
              onChanged: (value) => _onLocationChanged(value, true),
              onTap: () => setState(() {
                _showStartSuggestions = true;
                _showDestinationSuggestions = false;
              }),
            ),
            const SizedBox(height: 32),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: LocationTextField(
                    controller: _destinationController,
                    label: 'Destino del viaje',
                    prefixIcon: const Icon(Icons.flag),
                    onClear: _clearDestinationInput,
                    isLoading: _loadingDestination,
                    onChanged: (value) => _onLocationChanged(value, false),
                    onTap: () => setState(() {
                      _showDestinationSuggestions = true;
                      _showStartSuggestions = false;
                    }),
                  ),
                ),
                const SizedBox(width: 8.0),
                SwapLocationsButton(onPressed: _swapLocations),
              ],
            ),
            const SizedBox(height: 32),
            if (_showStartSuggestions)
              SuggestionsList(
                suggestions: _startSuggestions,
                isLoading: _loadingStart,
                onSuggestionSelected: (suggestion) {
                  _startController.text = suggestion;
                  setState(() {
                    _showStartSuggestions = false;
                    _startSuggestions = [];
                  });
                  FocusScope.of(context).unfocus();
                },
              ),
            if (_showDestinationSuggestions)
              SuggestionsList(
                suggestions: _destinationSuggestions,
                isLoading: _loadingDestination,
                onSuggestionSelected: (suggestion) {
                  _destinationController.text = suggestion;
                  setState(() {
                    _showDestinationSuggestions = false;
                    _destinationSuggestions = [];
                  });
                  FocusScope.of(context).unfocus();
                },
              ),
          ],
        ),
      ),
      bottomSheet:
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomButton(
          text: 'Solicitar viaje',
          onPressed: _navigateToTripMap,
        ),
      ),
    );
  }
}
