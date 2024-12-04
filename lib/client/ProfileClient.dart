import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:tubes_pbp_6/helper/shared_preference.helper.entity.dart';
import '../entity/profile.dart';

class ProfileClient {
  static const String baseUrl = 'http://10.0.2.2:8000';
  static const String getProfileEndpoint = '/api/profile/getProfile';
  static const String updateProfileEndpoint = '/api/profile/updateProfile';

  // Get Profile
  static Future<http.Response> getProfile() async {
    try {
      final token = await SharedPreferenceHelper.getString('token');
      if (token == null || token.isEmpty) {
        throw Exception("No token found. Please login first.");
      }

      final response = await http.get(
        Uri.parse('$baseUrl$getProfileEndpoint'),
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

  // Update Profile with Image (Multipart Request)
  static Future<http.Response> update({required Profile profile}) async {
    try {
      final token = await SharedPreferenceHelper.getString('token');
      if (token == null || token.isEmpty) {
        throw Exception("No token found. Please login first.");
      }
      print('ini profile');
      print(profile);

      final url = Uri.parse('$baseUrl$updateProfileEndpoint');
      var request = http.MultipartRequest('POST', url)
        ..headers.addAll({
          'Authorization': 'Bearer $token',
        });

      // Tambahkan field lainnya
      request.fields['nama_depan'] = profile.nama_depan ?? '';
      request.fields['nama_belakang'] = profile.nama_belakang ?? '';
      request.fields['email'] = profile.email ?? '';
      request.fields['nomor_telepon'] = profile.nomor_telepon ?? '';
      request.fields['tanggal_lahir'] = profile.tanggal_lahir ?? '';
      request.fields['height'] = profile.height?.toString() ?? '';
      request.fields['weight'] = profile.weight?.toString() ?? '';

      // Menambahkan gambar jika ada
      if (profile.profile_picture != null &&
          profile.profile_picture!.isNotEmpty) {
        // Jika profile_picture adalah path lokal
        var imageFile = await http.MultipartFile.fromPath(
          'profile_picture',
          profile.profile_picture!, // Path gambar
          contentType: MediaType('image', 'jpeg'),
        );
        request.files.add(imageFile);
      }

      final response = await request.send();
      return await http.Response.fromStream(response);
    } catch (e) {
      return Future.error("Error during profile update: $e");
    }
  }
}
