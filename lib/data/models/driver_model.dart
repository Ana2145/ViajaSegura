import 'package:viaja_segura_movil/data/models/personal_info_model.dart';
import 'package:viaja_segura_movil/data/models/status_model.dart';
import 'package:viaja_segura_movil/data/models/vehicle_model.dart';

class DriverModel {
  final int id;
  final String name;
  final String lastName;
  final String birthDate;
  final String sex;
  final String curp;
  final String municipality;
  final String city;
  final String email;
  final String phone;
  final String? qrCodeBase64;
  final StatusModel status;
  final double averageRating;
  final PersonalInfoModel personalInfo;
  final VehicleModel vehicle;
  final String createdAt;
  final String updatedAt;
  final bool available;

  DriverModel({
    required this.id,
    required this.name,
    required this.lastName,
    required this.birthDate,
    required this.sex,
    required this.curp,
    required this.municipality,
    required this.city,
    required this.email,
    required this.phone,
    this.qrCodeBase64,
    required this.status,
    required this.averageRating,
    required this.personalInfo,
    required this.vehicle,
    required this.createdAt,
    required this.updatedAt,
    required this.available,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      id: json['id'],
      name: json['name'],
      lastName: json['lastName'],
      birthDate: json['birthDate'],
      sex: json['sex'],
      curp: json['curp'],
      municipality: json['municipality'],
      city: json['city'],
      email: json['email'],
      phone: json['phone'],
      qrCodeBase64: json['qrCodeBase64'],
      status: StatusModel.fromJson(json['status']),
      averageRating: (json['averageRating'] as num).toDouble(),
      personalInfo: PersonalInfoModel.fromJson(json['personalInfo']),
      vehicle: VehicleModel.fromJson(json['vehicle']),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      available: json['available'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lastName': lastName,
      'birthDate': birthDate,
      'sex': sex,
      'curp': curp,
      'municipality': municipality,
      'city': city,
      'email': email,
      'phone': phone,
      'qrCodeBase64': qrCodeBase64,
      'status': status.toJson(),
      'averageRating': averageRating,
      'personalInfo': personalInfo.toJson(),
      'vehicle': vehicle.toJson(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'available': available,
    };
  }
}
