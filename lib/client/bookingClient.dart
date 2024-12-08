import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tubes_pbp_6/helper/shared_preference.helper.entity.dart';
import '../entity/booking.dart'; // Entity Booking

class BookingClient {
  static const String baseUrl = 'http://10.0.2.2:8000';

  // Endpoint untuk booking
  static const String createBookingEndpoint = '/api/booking';
  static const String getLatestBookingEndpoint = '/api/booking';
  static const String updateReminderBookingEndpoint =
      '/api/booking/{bookingId}/reminder';
  static const String payAndBookEndpoint = '/api/booking/{bookingId}/pay';
  static const String cancelBookingEndpoint = '/api/booking/{bookingId}';

  // API untuk mengambil user_id berdasarkan token
  static Future<int?> getUserIdFromToken() async {
    try {
      final token = await SharedPreferenceHelper.getString('token');

      if (token == null || token.isEmpty) {
        return null; // Jika token tidak ditemukan
      }

      // Menggunakan header Bearer token
      final response = await http.get(
        Uri.parse('$baseUrl/getUserId'), // Sesuaikan endpoint API
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Pastikan response memiliki 'user_id'
        if (data['user_id'] != null) {
          return data['user_id']; // Mengambil user_id dari response
        } else {
          throw Exception('user_id not found in response');
        }
      } else {
        throw Exception('Failed to fetch user data: ${response.statusCode}');
      }
    } catch (e) {
      // Tangani exception
      print("Error fetching user ID: $e");
      return null;
    }
  }

  // Membuat booking baru
  static Future<void> bookClass(int layananId) async {
    // Ambil token dari SharedPreferences
    final token = await SharedPreferenceHelper.getString('token');
    if (token == null || token.isEmpty) {
      throw Exception('Token is missing or empty');
    }

    final url = Uri.parse('http://10.0.2.2:8000/api/booking');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'layanan_id': layananId, // Kirimkan layanan_id untuk booking
      }),
    );

    if (response.statusCode == 201) {
      // Booking berhasil
      final booking = json.decode(response.body);
      print("Booking berhasil: ${booking['id']}");
    } else {
      // Jika gagal
      final errorMessage = json.decode(response.body)['message'];
      print("Error: $errorMessage");
      throw Exception('Failed to book class');
    }
  }

  // Ambil booking terbaru
  static Future<Booking> getLatestBooking() async {
    final response =
        await http.get(Uri.parse(baseUrl + getLatestBookingEndpoint));

    if (response.statusCode == 200) {
      return Booking.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load latest booking');
    }
  }

  // Update reminder time for booking
  static Future<http.Response> updateReminderTime(
      int bookingId, String reminderTime) async {
    try {
      final token = await SharedPreferenceHelper.getString('token');

      if (token == null || token.isEmpty) {
        throw Exception("No token found. Please login first.");
      }

      final response = await http.put(
        Uri.http(
            baseUrl,
            updateReminderBookingEndpoint.replaceAll(
                "{bookingId}", bookingId.toString())),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({'reminder_time': reminderTime}),
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to update reminder time');
      }
    } catch (e) {
      return Future.error("Error during update reminder time: $e");
    }
  }

  // Pay and book (update booking state)
  static Future<http.Response> payAndBook(int bookingId) async {
    try {
      final token = await SharedPreferenceHelper.getString('token');

      if (token == null || token.isEmpty) {
        throw Exception("No token found. Please login first.");
      }

      final response = await http.put(
        Uri.http(baseUrl,
            payAndBookEndpoint.replaceAll("{bookingId}", bookingId.toString())),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to pay and book');
      }
    } catch (e) {
      return Future.error("Error during pay and book: $e");
    }
  }

  // Cancel booking
  static Future<http.Response> cancelBooking(int bookingId) async {
    try {
      final token = await SharedPreferenceHelper.getString('token');

      if (token == null || token.isEmpty) {
        throw Exception("No token found. Please login first.");
      }

      final response = await http.delete(
        Uri.http(
            baseUrl,
            cancelBookingEndpoint.replaceAll(
                "{bookingId}", bookingId.toString())),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to cancel booking');
      }
    } catch (e) {
      return Future.error("Error during cancel booking: $e");
    }
  }
}
