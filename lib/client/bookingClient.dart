import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tubes_pbp_6/helper/shared_preference.helper.entity.dart';
import '../entity/booking.dart';  // Entity Booking

class BookingClient {
  static const String baseUrl = 'http://10.0.2.2:8000';
  
  // Endpoint untuk booking
  static const String createBookingEndpoint = '/api/booking';
  static const String getLatestBookingEndpoint = '/api/booking';
  static const String updateReminderBookingEndpoint = '/api/booking/{bookingId}/reminder';
  static const String payAndBookEndpoint = '/api/booking/{bookingId}/pay';
  static const String cancelBookingEndpoint = '/api/booking/{bookingId}';
  
  // Membuat booking baru
  static Future<Booking> createBooking(Booking booking) async {
    final response = await http.post(
      Uri.parse(baseUrl + createBookingEndpoint),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(booking.toJson()),
    );

    if (response.statusCode == 201) {
      return Booking.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create booking');
    }
  }
  
  // Ambil booking terbaru
  static Future<Booking> getLatestBooking() async {
    final response = await http.get(Uri.parse(baseUrl + getLatestBookingEndpoint));

    if (response.statusCode == 200) {
      return Booking.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load latest booking');
    }
  }

  // Update reminder time for booking
  static Future<http.Response> updateReminderTime(int bookingId, String reminderTime) async {
    try {
      final token = await SharedPreferenceHelper.getString('token');

      if (token == null || token.isEmpty) {
        throw Exception("No token found. Please login first.");
      }

      final response = await http.put(
        Uri.http(baseUrl, updateReminderBookingEndpoint.replaceAll("{bookingId}", bookingId.toString())),
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
        Uri.http(baseUrl, payAndBookEndpoint.replaceAll("{bookingId}", bookingId.toString())),
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
        Uri.http(baseUrl, cancelBookingEndpoint.replaceAll("{bookingId}", bookingId.toString())),
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
