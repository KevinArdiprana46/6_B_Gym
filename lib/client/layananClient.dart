import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tubes_pbp_6/helper/shared_preference.helper.entity.dart';
import '../entity/layanan.dart'; // Entity Layanan

class LayananClient {
  static const String baseUrl = 'http://10.0.2.2:8000';

  // Endpoint untuk layanan
  static const String getLayananEndpoint = '/api/layanan';
  static const String getLayananByIdEndpoint = '/api/layanan/{id}';
  static const String getLayananByDateEndpoint = '/api/layanan/date/{date}';
  static const String createLayananEndpoint = '/api/layanan';
  static const String updateLayananEndpoint = '/api/layanan/{id}';
  static const String deleteLayananEndpoint = '/api/layanan/{id}';

  // Ambil semua layanan
  static Future<List<Layanan>> getLayanan() async {
    final response = await http.get(Uri.parse(baseUrl + getLayananEndpoint));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Layanan.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load services');
    }
  }

  // Ambil layanan berdasarkan ID
  static Future<Layanan> getLayananById(int id) async {
    final response = await http.get(Uri.parse(
        baseUrl + getLayananByIdEndpoint.replaceFirst('{id}', '$id')));

    if (response.statusCode == 200) {
      return Layanan.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load service by ID');
    }
  }

  // Get layanan by date
  static Future<List<Layanan>> getLayananByDate(String date) async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/layanan/date/$date'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((item) => Layanan.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load layanan by date');
      }
    } catch (e) {
      return Future.error("Error during get layanan by date: $e");
    }
  }
}
