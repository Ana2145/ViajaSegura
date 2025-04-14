class PersonalInfoModel {
  final int id;
  final String licenseId;
  final bool testPassed;
  final String badgeExpiration;

  PersonalInfoModel({
    required this.id,
    required this.licenseId,
    required this.testPassed,
    required this.badgeExpiration,
  });

  factory PersonalInfoModel.fromJson(Map<String, dynamic> json) {
    return PersonalInfoModel(
      id: json['id'],
      licenseId: json['licenseId'],
      testPassed: json['testPassed'],
      badgeExpiration: json['badgeExpiration'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'licenseId': licenseId,
      'testPassed': testPassed,
      'badgeExpiration': badgeExpiration,
    };
  }
}
