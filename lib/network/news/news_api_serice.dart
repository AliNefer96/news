import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:news/models/news/news_model.dart';
import 'package:news/src/app_endpoints.dart';

class NewsApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: AppEndpoints.newsUrl,
  ));

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<List<NewsArticle>> fetchNews({int page = 0, int pageSize = 10}) async {
    try {
      String? token = await _storage.read(key: "jwt");

      if (token == null) {
        throw Exception("Unauthorized: No token found");
      }

      final response = await _dio.post(
        AppEndpoints.newsUrl,
      data: jsonEncode({"page": page, "pageSize": pageSize}),
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200 && response.data["result"]["hasItems"]) {
        List<dynamic> data = response.data["result"]["results"];
        return data.map((json) => NewsArticle.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      throw Exception("Failed to load news: ${e.toString()}");
    }
  }
  Future<NewsArticle> fetchNewsDetails(String newsId) async {
  try {
    String? token = await _storage.read(key: "jwt");

    if (token == null) {
      throw Exception("Unauthorized: No token found");
    }

    final response = await _dio.get(
      "${AppEndpoints.newsDetailsUrl}$newsId",
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      ),
    );

    if (response.statusCode == 200) {
      return NewsArticle.fromJsonDetails(response.data["result"]);
    }

    throw Exception("Failed to load news details");
  } catch (e) {
    throw Exception("Error fetching news details: ${e.toString()}");
  }
}
Future<bool> logout() async {
    try {
      await _storage.delete(key: 'access_token');
      return true;
    } catch (e) {
      return false;
    }
  }

}
