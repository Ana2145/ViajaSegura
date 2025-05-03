import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapLocationServices {
  final Location _location = Location();

  Future<LocationData?> getCurrentLocation() async {
    try {
      return await _location.getLocation();
    } catch (e) {
      return null;
    }
  }

  Future<bool> checkAndRequestService() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
    }
    return serviceEnabled;
  }

  Future<bool> checkAndRequestPermission() async {
    PermissionStatus permission = await _location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await _location.requestPermission();
    }
    return permission == PermissionStatus.granted;
  }

  Future<String> getAddressFromLatLng(double lat, double lng) async {
    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lng&zoom=18&addressdetails=1',
    );

    try {
      final response = await http.get(
        url,
        headers: {
          'User-Agent': 'viaja_segura_app/1.0 (contacto@tuapp.com)',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['display_name'] as String? ?? "Ubicación no encontrada";
      } else {
        return "Error al obtener dirección";
      }
    } catch (e) {
      return "Error al obtener dirección";
    }
  }
}
