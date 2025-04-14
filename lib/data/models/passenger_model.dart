class PassengerModel {
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
  final String createdAt;
  final String updatedAt;

  PassengerModel({
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
    required this.createdAt,
    required this.updatedAt,
  });

  factory PassengerModel.fromJson(Map<String, dynamic> json) {
    return PassengerModel(
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
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
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
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
