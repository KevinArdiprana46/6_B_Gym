import 'dart:convert';
import 'package:http/http.dart' as http;
import '../entity/pembayaran.dart'; // Entity Pembayaran
import '../helper/shared_preference.helper.entity.dart'; // SharedPreferenceHelper untuk token

class PembayaranClient {
  static const String baseUrl = 'http://10.0.2.2:8000';

  // Endpoint untuk pembayaran
  static const String createPembayaranEndpoint = '/api/pembayaran';
  static const String getPembayaranEndpoint = '/api/pembayaran';
  static const String getPembayaranByIdEndpoint = '/api/pembayaran/{id}';
  static const String getHistoryPembayaranEndpoint = '/api/pembayaran/history';

  // Buat pembayaran baru
  static Future<bool> createPembayaran(Pembayaran pembayaran) async {
    final token = await SharedPreferenceHelper.getString('token');
    if (token == null || token.isEmpty) {
      throw Exception('Token is missing or empty');
    }

    final response = await http.post(
      Uri.parse(baseUrl + createPembayaranEndpoint),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(pembayaran.toJson()),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to create payment');
    }
  }

  // Ambil semua pembayaran
  static Future<List<Pembayaran>> getPembayaran() async {
    final token = await SharedPreferenceHelper.getString('token');
    if (token == null || token.isEmpty) {
      throw Exception('Token is missing or empty');
    }

    final response = await http.get(
      Uri.parse(baseUrl + getPembayaranEndpoint),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Pembayaran.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load payments');
    }
  }

  // Ambil pembayaran berdasarkan ID
  static Future<Pembayaran> getPembayaranById(int id) async {
    final token = await SharedPreferenceHelper.getString('token');
    if (token == null || token.isEmpty) {
      throw Exception('Token is missing or empty');
    }

    final response = await http.get(
      Uri.parse(baseUrl + getPembayaranByIdEndpoint.replaceFirst('{id}', '$id')),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return Pembayaran.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load payment by ID');
    }
  }

  // Ambil riwayat pembayaran
  static Future<List<Pembayaran>> getHistoryPembayaran() async {
    final token = await SharedPreferenceHelper.getString('token');
    if (token == null || token.isEmpty) {
      throw Exception('Token is missing or empty');
    }

    final response = await http.get(
      Uri.parse(baseUrl + getHistoryPembayaranEndpoint),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Pembayaran.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load payment history');
    }
  }
}
