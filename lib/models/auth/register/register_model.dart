import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news/blocs/auth/register/register_event.dart';

class RegisterUserModel extends RegisterEvent{
  final String? tenantId = dotenv.env['TENANT_ID'];
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String password;
  final String birthDate;
  final String? pictureId;
  final bool sendBirthdayCardAutomatically;

  RegisterUserModel({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.birthDate,
     this.pictureId,
    required this.sendBirthdayCardAutomatically,
  });

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "email": email,
        "tenantId": tenantId,
        "password": password,
        "birthDate": birthDate,
        "pictureId": 'string',
        "sendBirthdayCardAutomatically": sendBirthdayCardAutomatically,
      };
}