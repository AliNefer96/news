class AppEndpoints {
  static const Map<String, dynamic> apiHeader = {
      "Accept-Language": "",
      "X-Api-Version": "1.0",
      "Content-Type": "application/json",
    };
  static const String baseUrl = "https://api.arena-collabiz.ito.dev/api";
  static const String registerUrl = "$baseUrl/account/register";
  static const String loginUrl = "$baseUrl/auth/token";
  static const String refreshToken = "$baseUrl/auth/token-refresh";
  static const String newsUrl = "$baseUrl/news";
  static const String newsDetailsUrl = "$baseUrl/news/";
  }

