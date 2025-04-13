class AuthResponse {
  final String token;
  final String role;
  final int id;
  final bool error;
  final int statusCode;
  final String message;

  AuthResponse({
    required this.token,
    required this.role,
    required this.id,
    required this.error,
    required this.statusCode,
    required this.message,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'],
      role: json['role'],
      id: json['id'],
      error: json['error'] ?? false,
      statusCode: json['statusCode'] ?? 200,
      message: json['message'] ?? 'No message provided',
    );
  }
}
