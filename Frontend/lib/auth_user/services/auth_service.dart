import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:project_pfe2/auth_user/models/register_request.dart';
import 'package:project_pfe2/auth_user/models/user_model.dart';

class AuthService {
  final logger = Logger();
  final String baseUrl = "http://10.0.2.2:8080/auth";

  Future<UserModel> login(String email, String password) async {
    final url = Uri.parse("$baseUrl/sign-in");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return UserModel.fromJson(body);
      } else {
        logger.e("Login failed: ${response.body}");
        throw Exception("Login failed: ${response.body}");
      }
    } catch (e) {
      logger.e("Login error: $e");
      throw Exception("Login error: $e");
    }
  }

Future<String?> register(RegisterRequest request) async {
  final url = Uri.parse("$baseUrl/sign-up");

  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(request.toJson()),  // استخدم toJson هنا
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return body['token'];
    } else {
      logger.e("Register failed: ${response.body}");
      return null;
    }
  } catch (e) {
    logger.e("Register error: $e");
    return null;
  }
}
}
