import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tubes_pbp_6/entity/loginresponse.dart';
import 'package:tubes_pbp_6/helper/shared_preference.helper.entity.dart';
import '../entity/user.dart';

class UserClient {
  static const String baseUrl = '10.0.2.2:8000'; 
  static const String registerEndPoint = '/api/register';
  static const String loginEndPoint = '/api/login';

  /// Register User
  static Future<Map<String, dynamic>> register(User user) async {
    try {
      print( Uri.http(baseUrl, registerEndPoint));
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
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.http(baseUrl, loginEndPoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        var a = Loginresponse.fromJson(jsonDecode(response.body));
        print(response.body);
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
}
