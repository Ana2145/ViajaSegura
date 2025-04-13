class DriverModel {
  final int id;
  final String name;
  final String lastname;
  final String email;
  final String phoneNumber;

  DriverModel(
      {required this.id,
      required this.name,
      required this.lastname,
      required this.email,
      required this.phoneNumber});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lastname': lastname,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      id: json['id'],
      name: json['name'] ?? '',
      lastname: json['lastName'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone'] ?? '',
    );
  }
}
