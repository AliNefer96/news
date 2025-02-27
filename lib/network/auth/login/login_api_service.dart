import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:news/models/auth/login/login_model.dart';
import 'package:news/src/app_endpoints.dart';

class LoginApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: AppEndpoints.baseUrl,
    headers: AppEndpoints.apiHeader,
  ));

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<bool> loginUser(LoginUserModel user) async {
  try {
    final response = await _dio.post(
      AppEndpoints.loginUrl,
      data: user.toJson(),
    );

    if (response.statusCode == 200) {
      final result = response.data["result"];
      final accessToken = result["accessToken"]["token"];
      final refreshToken = result["refreshToken"]["token"];

      await _storage.write(key: "jwt", value: accessToken);
      await _storage.write(key: "refresh_token", value: refreshToken);

      return true;
    }
  } on DioException catch (e) {
    print("Login failed: ${e.response?.data}");
  }
  return false;
}


  Future<String?> getAccessToken() async {
    final expiration = await _storage.read(key: 'tokenExpiration');
    final now = DateTime.now();

    if (expiration != null && DateTime.parse(expiration).isAfter(now)) {
      return await _storage.read(key: 'accessToken');
    } else {
      return await refreshAccessToken();
    }
  }

  Future<String?> refreshAccessToken() async {
    final refreshToken = await _storage.read(key: 'refreshToken');
    if (refreshToken == null) return null;

    try {
      final response = await _dio.post(AppEndpoints.refreshToken, data: {"refreshToken": refreshToken});

      final data = response.data['result'];
      final newAccessToken = data['accessToken']['token'];
      final expireInSeconds = data['accessToken']['expireInSeconds'];

      await _storage.write(key: 'accessToken', value: newAccessToken);
      await _storage.write(key: 'tokenExpiration', value: DateTime.now().add(Duration(seconds: expireInSeconds)).toIso8601String());

      return newAccessToken;
    } on DioException {
      return null;
    }
  }

  Future<void> logout() async {
    await _storage.deleteAll();
  }
}
