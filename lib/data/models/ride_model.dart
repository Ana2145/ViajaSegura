class RideModel {
  final int id;
  final PassengerModel passenger;
  final DriverModel driver;
  final String originLat;
  final String originLng;
  final String destinationLat;
  final String destinationLng;
  final double price;
  final String startedAt;
  final String endedAt;
  final double averageRating;

  RideModel({
    required this.id,
    required this.passenger,
    required this.driver,
    required this.originLat,
    required this.originLng,
    required this.destinationLat,
    required this.destinationLng,
    required this.price,
    required this.startedAt,
    required this.endedAt,
    required this.averageRating,
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
      price: json['price'].toDouble(),
      startedAt: json['startedAt'],
      endedAt: json['endedAt'],
      averageRating: json['driver']['averageRating'].toDouble(),
    );
  }
}

class PassengerModel {
  final String name;
  final String lastName;

  PassengerModel({
    required this.name,
    required this.lastName,
  });

  factory PassengerModel.fromJson(Map<String, dynamic> json) {
    return PassengerModel(
      name: json['name'],
      lastName: json['lastName'],
    );
  }
}

class DriverModel {
  final String name;
  final String lastName;
  final double averageRating;

  DriverModel({
    required this.name,
    required this.lastName,
    required this.averageRating,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      name: json['name'],
      lastName: json['lastName'],
      averageRating: json['averageRating'].toDouble(),
    );
  }
}
