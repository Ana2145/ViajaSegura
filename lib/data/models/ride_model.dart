import 'package:viaja_segura_movil/data/models/driver_model.dart';
import 'package:viaja_segura_movil/data/models/passenger_model.dart';
import 'package:viaja_segura_movil/data/models/status_model.dart';

class RideModel {
  final int id;
  final PassengerModel passenger;
  final DriverModel? driver;
  final double originLat;
  final double originLng;
  final double destinationLat;
  final double destinationLng;
  final StatusModel status;
  final double? price;
  final double? distanceKm;
  final String? startedAt;
  final String? endedAt;
  final String createdAt;
  final String updatedAt;

  RideModel({
    required this.id,
    required this.passenger,
    required this.driver,
    required this.originLat,
    required this.originLng,
    required this.destinationLat,
    required this.destinationLng,
    required this.status,
    required this.price,
    required this.distanceKm,
    required this.startedAt,
    required this.endedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RideModel.fromJson(Map<String, dynamic> json) {
    return RideModel(
      id: json['id'],
      passenger: PassengerModel.fromJson(json['passenger']),
      driver: json['driver'] != null ? DriverModel.fromJson(json['driver']) : null,
      originLat: (json['originLat'] as num).toDouble(),
      originLng: (json['originLng'] as num).toDouble(),
      destinationLat: (json['destinationLat'] as num).toDouble(),
      destinationLng: (json['destinationLng'] as num).toDouble(),
      status: StatusModel.fromJson(json['status']),
      price: json['price'] != null ? (json['price'] as num).toDouble() : null,
      distanceKm: json['distanceKm'] != null ? (json['distanceKm'] as num).toDouble() : null,
      startedAt: json['startedAt'],
      endedAt: json['endedAt'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'passenger': passenger.toJson(),
      'driver': driver?.toJson(),
      'originLat': originLat,
      'originLng': originLng,
      'destinationLat': destinationLat,
      'destinationLng': destinationLng,
      'status': status.toJson(),
      'price': price,
      'distanceKm': distanceKm,
      'startedAt': startedAt,
      'endedAt': endedAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
