import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:project_pfe2/auth_user/models/user_model.dart';
import 'dart:convert';

class UserService {
  final baseUrl = "http://10.0.2.2:8080/user";
  final logger = Logger();
  Future<List<UserModel>> getAllUsers() async {
    final response = await http.get(Uri.parse("$baseUrl/all"));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load users");
    }
  }
  Future<Map<String, dynamic>?> updateUser(int id, Map<String, dynamic> updates) async {
      final url = Uri.parse('$baseUrl/update/$id');

      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(updates),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        logger.e('❌ Error updating user: ${response.body}');
        return null;
      }
    }
  Future<void> deleteUser(int id) async {
    await http.delete(Uri.parse("$baseUrl/delete/$id"));
  }
}
