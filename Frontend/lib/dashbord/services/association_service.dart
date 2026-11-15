import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:project_pfe2/auth_association/models/association_model.dart';

class AssociationService {
  final String baseUrl = "http://10.0.2.2:8080/user/associations";

  Future<List<AssociationModel>> getAll() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => AssociationModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load associations");
    }
  }

  Future<void> update(int id) async {
    await http.put(
      Uri.parse("$baseUrl/$id?statue=accepted"),
      headers: {"Content-Type": "application/json"},
    );
  }

  Future<void> delete(int id) async {
    await http.delete(Uri.parse("$baseUrl/$id"));
  }
  Future<bool> updateAssociation(int id, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse("$baseUrl/update/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    return response.statusCode == 200;
  }
}
