import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/event_model.dart';

class EventService {
  final String baseUrl = "http://10.0.2.2:8080/api/events";

  Future<bool> addEvent(Event event) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(event.toJson()),
    );
    return response.statusCode == 200;
  }

  Future<bool> updateEvent(Event event) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update/${event.id}'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(event.toJson()),
    );
    return response.statusCode == 200;
  }

  Future<bool> deleteEvent(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/delete/$id'),
    );
    return response.statusCode == 200;
  }

  Future<List<Event>> getAllEvents() async {
    final response = await http.get(Uri.parse('$baseUrl/all'));
    if (response.statusCode == 200) {
      final List<dynamic> decoded = jsonDecode(response.body);
      return decoded.map((e) => Event.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load events');
    }
  }
    Future<List<Event>> getAllEventsByAssociationId(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      final List<dynamic> decoded = jsonDecode(response.body);
      return decoded.map((e) => Event.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load events');
    }
  }
}
