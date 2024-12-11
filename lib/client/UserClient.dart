import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tubes_pbp_6/entity/loginresponse.dart';
import 'package:tubes_pbp_6/helper/shared_preference.helper.entity.dart';
import '../entity/user.dart';

class UserClient {
  static const String baseUrl = '10.0.2.2:8000';
  static const String registerEndPoint = '/api/register';
  static const String loginEndPoint = '/api/login';

  static Future<Map<String, dynamic>> getUserLogin() async {
    final token = SharedPreferenceHelper.getString('token');
    if (token.isEmpty) {
      throw Exception('Token not found');
    }
    print("haha");
    final response = await http.get(
      Uri.http(baseUrl, '/api/users/getUserLogin'),
      headers: {'Authorization': 'Bearer $token'},
    );
    //  print("masuk gakk ${response.body}");
    // print(response.body);

    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      // print(res['user']);

      return res;
    } else {
      throw Exception('Failed to fetch user data');
    }
  }

  /// Register User
  static Future<Map<String, dynamic>> register(User user) async {
    try {
      print(Uri.http(baseUrl, registerEndPoint));
      final response = await http.post(
        Uri.http(baseUrl, registerEndPoint),
        headers: {'Content-Type': 'application/json'},
        body: user.toRawJson(),
      );
      print(response.body);
      print(user.toRawJson());
      if (response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        throw Exception(
          "Failed to register. Code: ${response.statusCode}, Message: ${response.reasonPhrase}",
        );
      }
    } catch (e) {
      return Future.error("Error during registration: $e");
    }
  }

  /// Login User
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    try {
      final response = await http.post(
        Uri.http(baseUrl, loginEndPoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        var a = Loginresponse.fromJson(jsonDecode(response.body));
        // print(response.body);
        SharedPreferenceHelper.setString('token', a.token!);
        print(a.token);
        return json.decode(response.body);
      } else {
        throw Exception(
          "Failed to login. Code: ${response.statusCode}, Message: ${response.reasonPhrase}",
        );
      }
    } catch (e) {
      return Future.error("Error during login: $e");
    }
  }

  static Future<Map<String, dynamic>> getUserData(int userId) async {
    final String url =
        'http://10.0.2.2:8000/api/getUserData/$userId'; // Menggunakan userId dalam bentuk string

    try {
      // Melakukan permintaan GET ke API
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Jika server mengembalikan status OK (200), parse response JSON
        Map<String, dynamic> userData = json.decode(response.body);
        return userData;
      } else {
        // Jika server gagal merespons dengan status selain 200
        throw Exception('Gagal mengambil data pengguna');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}
