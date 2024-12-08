import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
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
          'Accept': 'application/json',
        });
      request.fields['nama_depan'] = profile.nama_depan ?? '';
      request.fields['nama_belakang'] = profile.nama_belakang ?? '';
      request.fields['nomor_telepon'] = profile.nomor_telepon ?? '';
      request.fields['email'] = profile.email ?? '';

      // Format tanggal_lahir ke format 'YYYY-MM-DD'
      String formattedDate = '';
      if (profile.tanggal_lahir != null) {
        try {
          if (profile.tanggal_lahir is String) {
            DateTime parsedDate = DateTime.parse(profile.tanggal_lahir!);
            formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
          } else if (profile.tanggal_lahir is DateTime) {
            formattedDate = DateFormat('yyyy-MM-dd')
                .format(profile.tanggal_lahir! as DateTime);
          }
        } catch (e) {
          throw Exception(
              "Invalid date format for tanggal_lahir: ${profile.tanggal_lahir}");
        }
      }
      request.fields['tanggal_lahir'] = formattedDate;
      request.fields['height'] = profile.height?.toString() ?? '0';
      request.fields['weight'] = profile.weight?.toString() ?? '0';
      if (profile.profile_picture != null) {
        final profilePicFile = File(profile.profile_picture!);
        if (await profilePicFile.exists()) {
          request.files.add(
            await http.MultipartFile.fromPath(
              'profile_picture',
              profilePicFile.path,
              contentType: MediaType('image', 'jpeg'),
            ),
          );
        }
      }
      final response = await request.send();
      if (response.statusCode == 200) {
        return await http.Response.fromStream(response);
      } else {
        throw Exception(
            'Failed to update profile. Status code: ${response.statusCode}');
      }
    } catch (e) {
      return Future.error("Error during profile update: $e");
    }
  }
}
