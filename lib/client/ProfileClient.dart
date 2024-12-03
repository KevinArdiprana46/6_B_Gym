import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tubes_pbp_6/helper/shared_preference.helper.entity.dart';
import '../entity/profile.dart';

class ProfileClient {
  static const String baseUrl = '10.0.2.2:8000';
  static const String getProfileEndpoint = '/api/profile/getProfile';
  static const String updateProfileEndpoint = '/api/profile/updateProfile';

  // Get Profile
  static Future<http.Response> getProfile() async {
    try {
      // Ambil token dari Shared Preferences
      final token = await SharedPreferenceHelper.getString('token');

      // Validasi jika token null atau kosong
      if (token == null || token.isEmpty) {
        throw Exception("No token found. Please login first.");
      }

      final response = await http.get(
        Uri.http(baseUrl, getProfileEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error("Error during get profile: $e");
    }
  }

  // Update Profile
  static Future<http.Response> update(Profile profile) async {
    try {
      // Ambil token dari Shared Preferences
      final token = await SharedPreferenceHelper.getString('token');

      // Validasi jika token null atau kosong
      if (token == null || token.isEmpty) {
        throw Exception("No token found. Please login first.");
      }

      final response = await http.put(
        Uri.http(baseUrl, updateProfileEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: profile.toRawJson(),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error("Error during profile update: $e");
    }
  }
}
