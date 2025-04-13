class DriverModel {
  final String name;
  final String lastname;
  final String email;
  final String phoneNumber;

  DriverModel(
      {required this.name,
      required this.lastname,
      required this.email,
      required this.phoneNumber});

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      name: json['name'] ?? '',
      lastname: json['lastName'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone'] ?? '',
    );
  }
}
