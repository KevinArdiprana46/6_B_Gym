import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tubes_pbp_6/helper/shared_preference.helper.entity.dart';
import '../entity/layanan.dart';

class LayananClient {
  static const String baseUrl = 'http://10.0.2.2:8000';

  static const String getLayananEndpoint = '/api/layanan';
  static const String getLayananByIdEndpoint = '/api/layanan/{id}';
  static const String getLayananByDateEndpoint = '/api/layanan/date/{date}';
  static const String createLayananEndpoint = '/api/layanan';
  static const String updateLayananEndpoint = '/api/layanan/{id}';
  static const String deleteLayananEndpoint = '/api/layanan/{id}';

  static Future<List<Layanan>> getLayanan() async {
    final response = await http.get(Uri.parse(baseUrl + getLayananEndpoint));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Layanan.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load services');
    }
  }

  static Future<Layanan> getLayananById(int id) async {
    final response = await http.get(Uri.parse(
        baseUrl + getLayananByIdEndpoint.replaceFirst('{id}', '$id')));

    if (response.statusCode == 200) {
      return Layanan.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load service by ID');
    }
  }

  static Future<List<Layanan>> getLayananByDate(String date) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/layanan/date/$date'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Layanan.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load layanan');
      }
    } catch (e) {
      return Future.error("Error during get layanan by date: $e");
    }
  }

  static Future<List<Layanan>> getLayananWithBookingStatus(
      String selectedDate) async {
    final token = await SharedPreferenceHelper.getString('token');
    if (token == null || token.isEmpty) {
      throw Exception('Token is missing or empty');
    }
    
    final url = Uri.parse(
        '$baseUrl/api/layanan/date/$selectedDate/booking-status');

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((layanan) => Layanan.fromJson(layanan)).toList();
    } else {
      throw Exception('Failed to load layanan');
    }
  }

  Future<List<Layanan>> getClassesWithBookingStatus() async {
    final token = await SharedPreferenceHelper.getString('token');
    final response = await http.get(
      Uri.parse('$baseUrl/getAvailableClasses'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Layanan.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load classes');
    }
  }
}
