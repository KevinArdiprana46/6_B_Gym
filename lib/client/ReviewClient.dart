import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tubes_pbp_6/entity/review.dart';
import 'package:tubes_pbp_6/entity/review_respons.dart';
import 'package:tubes_pbp_6/helper/shared_preference.helper.entity.dart';

class ReviewClient {
  static const String baseUrl = 'http://10.0.2.2:8000'; 
  static const String getReviewsByServiceEndpoint = '/reviews/service';
  static const String addReviewEndpoint = '/reviews/store';

  static Future<List<review>> getReviewsByIdLayanan(int IdLayanan) async {
  final url = Uri.parse('$baseUrl/api/reviews?IdLayanan=$IdLayanan'); // Sesuaikan endpoint
  try {
    final response = await http.get(url);

    // Log untuk debugging
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((data) => review.fromJson(data)).toList();
    } else {
      throw Exception('Failed to fetch reviews. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching reviews: $e');
    rethrow;
  }
}

  static Future<ReviewRespon> getAll() async {
    final url = Uri.parse('$baseUrl/api/reviews'); // Sesuaikan endpoint
    try {
      final response = await http.get(url);

      // Log untuk debugging
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return ReviewRespon.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to fetch reviews. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching reviews: $e');
      rethrow;
    }
  }

  // Menambahkan review
  static Future<review> addReview(int layananId, review newReview) async {
  final token = await SharedPreferenceHelper.getString('token');
  print('isi data');
    print(newReview.layanan_id);
    print(layananId);
    if (token == null || token.isEmpty) {
      throw Exception("No token found. Please login first.");
    }

    final url = Uri.parse('$baseUrl/api/reviews/store');
    print('ini url ');
    print(url);
    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: newReview.toRawJson(),
      
      );
      print('hail ');
          print(response.body);

      print(newReview);
      print('Response Status Code: ${response.statusCode}');
      print('url ${url}');
      print('Token: $token');
      print('test');
      if (response.statusCode == 201) {
        print('tes');
        final jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        return review.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to add review');
      }
    } catch (e) {
      print('Error adding review: $e');
      rethrow;
    }
  }

  // Mengedit review
  static Future<review> updateReview(int reviewId, review updatedReview) async {
   final token = await SharedPreferenceHelper.getString('token');
    if (token == null || token.isEmpty) {
      throw Exception("No token found. Please login first.");
    }

    final url = Uri.parse('$baseUrl/api$addReviewEndpoint/$reviewId');
    try {
      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(updatedReview.toJson()),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return review.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to update review');
      }
    } catch (e) {
      print('Error updating review: $e');
      rethrow;
    }
  }

  // Menghapus review berdasarkan review ID
  static Future<void> deleteReview(int reviewId) async {
   final token = await SharedPreferenceHelper.getString('token');
    if (token == null || token.isEmpty) {
      throw Exception("No token found. Please login first.");
    }

    final url = Uri.parse('$baseUrl/api$addReviewEndpoint/$reviewId');
    try {
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete review');
      }
    } catch (e) {
      print('Error deleting review: $e');
      rethrow;
    }
  }
}
