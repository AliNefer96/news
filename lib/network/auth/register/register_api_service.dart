import 'package:dio/dio.dart';
import 'package:news/models/auth/register/register_model.dart';
import 'package:news/src/app_endpoints.dart';

class RegisterApiService {
  
  final Dio _dio = Dio(BaseOptions(
    baseUrl: AppEndpoints.registerUrl,
    headers: AppEndpoints.apiHeader,
  ));

  Future<Map<String, dynamic>> registerUser(RegisterUserModel user) async {
  try {
    print("Request Data: ${user.toJson()}"); 

    final response = await _dio.post(
      AppEndpoints.registerUrl,
      data: user.toJson(),
    );

    print("Response Data: ${response.data}"); 

    return {"success": true, "data": response.data};
  } on DioException catch (e) {
    print("DioException: ${e.response?.data}"); 

    if (e.response != null) {
      return {
        "success": false,
        "isValidationError": e.response!.data["isValidationError"] ?? false,
        "validationErrors": e.response!.data["validationErrors"] ?? {},
        "errors": e.response!.data["errors"] ?? []
      };
    }
    return {"success": false, "errors": ["Unexpected error occurred"]};
  }
}

}