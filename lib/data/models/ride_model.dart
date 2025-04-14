class RideModel {
  final int id;
  final String startedAt;
  final String endedAt;
  final double originLat;
  final double originLng;
  final double destinationLat;
  final double destinationLng;
  final double price;
  final Passenger passenger;

  RideModel({
    required this.id,
    required this.startedAt,
    required this.endedAt,
    required this.originLat,
    required this.originLng,
    required this.destinationLat,
    required this.destinationLng,
    required this.price,
    required this.passenger,
  });

  factory RideModel.fromJson(Map<String, dynamic> json) {
    return RideModel(
      id: json['id'],
      startedAt: json['startedAt'],
      endedAt: json['endedAt'],
      originLat: json['originLat'],
      originLng: json['originLng'],
      destinationLat: json['destinationLat'],
      destinationLng: json['destinationLng'],
      price: (json['price'] as num).toDouble(),
      passenger: Passenger.fromJson(json['passenger']),
    );
  }
}

class Passenger {
  final String name;
  final String lastName;

  Passenger({
    required this.name,
    required this.lastName,
  });

  factory Passenger.fromJson(Map<String, dynamic> json) {
    return Passenger(
      name: json['name'],
      lastName: json['lastName'],
    );
  }
}
