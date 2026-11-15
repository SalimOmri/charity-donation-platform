import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:project_pfe2/association/screens/event/models/donation_model.dart';

class DonationService {
  final String baseUrl = 'http://10.0.2.2:8080/api/donations';

  Future<bool> makeDonation(int userId, int eventId, double montant, String items) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$userId/$eventId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'montant': montant,
        'items': items,
      }),
    );
    return response.statusCode == 200;
  }

  Future<List<DonationModel>> getUserDonations(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/user/$userId'));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => DonationModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch donations');
    }
  }
}
