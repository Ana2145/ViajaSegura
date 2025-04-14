import 'package:viaja_segura_movil/data/models/status_model.dart';

class VehicleModel {
  final int id;
  final String plateNumber;
  final String brand;
  final String model;
  final String color;
  final int seats;
  final int year;
  final StatusModel status;
  final String createdAt;
  final String updatedAt;

  VehicleModel({
    required this.id,
    required this.plateNumber,
    required this.brand,
    required this.model,
    required this.color,
    required this.seats,
    required this.year,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'],
      plateNumber: json['plateNumber'],
      brand: json['brand'],
      model: json['model'],
      color: json['color'],
      seats: json['seats'],
      year: json['year'],
      status: StatusModel.fromJson(json['status']),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plateNumber': plateNumber,
      'brand': brand,
      'model': model,
      'color': color,
      'seats': seats,
      'year': year,
      'status': status.toJson(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
