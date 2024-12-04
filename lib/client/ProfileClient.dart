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

      final url = Uri.parse('$baseUrl$updateProfileEndpoint');
      var request = http.MultipartRequest('POST', url)
        ..headers.addAll({
          'Authorization': 'Bearer $token',
        });

      // Menambahkan data profil ke request
      request.fields['nama_depan'] = profile.nama_depan ?? '';
      request.fields['nama_belakang'] = profile.nama_belakang ?? '';
      request.fields['phone'] = profile.nomor_telepon ?? '';
      request.fields['date_of_birth'] = profile.tanggal_lahir ?? '';
      request.fields['height'] = profile.height?.toString() ?? '';
      request.fields['weight'] = profile.weight?.toString() ?? '';

      // Menambahkan gambar profil jika ada
      if (profile.profile_picture != null) {
        final profilePicFile = File(profile.profile_picture!);
        if (await profilePicFile.exists()) {
          request.files.add(await http.MultipartFile.fromPath(
            'profile_picture',
            profile.profile_picture!,
            contentType: MediaType('image', 'jpg'),
          ));
        }
      }

      final response = await request.send();
      print('Response status: ${response.statusCode}');
      print('Response headers: ${response.headers}');

      if (response.statusCode == 200) {
        return await http.Response.fromStream(response);
      } else if (response.statusCode == 302) {
        // Cek URL redirect
        print('Redirected to: ${response.headers['location']}');
        throw Exception("Redirected to login. Please login again.");
      } else {
        throw Exception(
            "Failed to update profile. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print('Error: $e');
      return Future.error("Error during update profile: $e");
    }
  }
}
