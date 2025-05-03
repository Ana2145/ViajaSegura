class RideModel {
  final int id;
  final PassengerModel passenger;
  final DriverModel driver;
  final String originLat;
  final String originLng;
  final String destinationLat;
  final String destinationLng;
  final RideStatusModel status;
  final double price;
  final double distanceKm;
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
    this.startedAt,
    this.endedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RideModel.fromJson(Map<String, dynamic> json) {
    return RideModel(
      id: json['id'],
      passenger: PassengerModel.fromJson(json['passenger']),
      driver: DriverModel.fromJson(json['driver']),
      originLat: json['originLat'].toString(),
      originLng: json['originLng'].toString(),
      destinationLat: json['destinationLat'].toString(),
      destinationLng: json['destinationLng'].toString(),
      status: RideStatusModel.fromJson(json['status']),
      price: (json['price'] as num).toDouble(),
      distanceKm: (json['distanceKm'] as num).toDouble(),
      startedAt: json['startedAt'],
      endedAt: json['endedAt'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class RideStatusModel {
  final int id;
  final String name;

  RideStatusModel({required this.id, required this.name});

  factory RideStatusModel.fromJson(Map<String, dynamic> json) {
    return RideStatusModel(
      id: json['id'],
      name: json['name'],
    );
  }
}

class PassengerModel {
  final int id;
  final String name;
  final String lastName;

  PassengerModel({
    required this.id,
    required this.name,
    required this.lastName,
  });

  factory PassengerModel.fromJson(Map<String, dynamic> json) {
    return PassengerModel(
      id: json['id'],
      name: json['name'],
      lastName: json['lastName'],
    );
  }
}

class DriverModel {
  final int id;
  final String name;
  final String lastName;
  final double? averageRating;

  DriverModel({
    required this.id,
    required this.name,
    required this.lastName,
    this.averageRating,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      id: json['id'],
      name: json['name'],
      lastName: json['lastName'],
      averageRating: json['averageRating'] != null
          ? (json['averageRating'] as num).toDouble()
          : null,
    );
  }
}
