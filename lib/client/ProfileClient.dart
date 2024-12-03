import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tubes_pbp_6/helper/shared_preference.helper.entity.dart';
import '../entity/profile.dart';

class ProfileClient {
  static const String baseUrl = 'http://10.0.2.2:8000';
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
        Uri.parse(
            '$baseUrl$getProfileEndpoint'), // Gunakan Uri.parse untuk memastikan URL valid
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Sertakan token dalam header
        },
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error("Error during get profile: $e");
    }
  }

  // Update Profile

  static Future<http.Response> update({required Profile profile}) async {
    try {
      // Ambil token dari Shared Preferences
      final token = await SharedPreferenceHelper.getString('token');

      // Validasi jika token null atau kosong
      if (token == null || token.isEmpty) {
        throw Exception("No token found. Please login first.");
      }
      print('ini profile');
      print(profile);

      final url = Uri.parse(
          '$baseUrl$updateProfileEndpoint'); // Endpoint untuk update profile tanpa ID
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Sertakan token dalam header
      };

      final body = jsonEncode({
        'nama_depan': profile.nama_depan,
        'nama_belakang': profile.nama_belakang,
        'email': profile.email,
        'nomor_telepon': profile.nomor_telepon,
        'password': profile.password,
        'tanggal_lahir': profile.tanggal_lahir,
        'height': profile.height,
        'weight': profile.weight,
        'jenis_kelamin': profile.jenis_kelamin,
        'profile_picture': profile.profile_picture,
      });

      final response = await http.post(url, headers: headers, body: body);
      return response;
    } catch (e) {
      return Future.error("Error during profile update: $e");
    }
  }
}
