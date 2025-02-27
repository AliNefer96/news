import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news/blocs/auth/login/login_event.dart';

class LoginUserModel extends LoginEvent {
  final String? tenantId = dotenv.env['TENANT_ID'];
  final String email;
  final String password;
  final bool isGuest;

  LoginUserModel({
    required this.email,
    required this.password,
    this.isGuest = false,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "tenantId": tenantId,
        "password": password,
        "isGuest": true,
      };

  factory LoginUserModel.fromJson(Map<String, dynamic> json) {
    return LoginUserModel(
      email: json["email"],
      password: json["password"],
      isGuest: json["isGuest"] ?? false,
    );
  }
}
