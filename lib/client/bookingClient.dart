import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tubes_pbp_6/helper/shared_preference.helper.entity.dart';
import '../entity/booking.dart';
import '../entity/layanan.dart';

class BookingClient {
  static const String baseUrl = 'http://10.0.2.2:8000';

  static const String createBookingEndpoint = '/api/booking';
  static const String getBookingIdEndpoint = '/api/booking';
  static const String getLatestBookingEndpoint = '/api/booking';
  static const String updateReminderBookingEndpoint =
      '/api/booking/{bookingId}/reminder';
  static const String payAndBookEndpoint = '/api/booking/{bookingId}/pay';
  static const String cancelBookingEndpoint = '/api/booking';

  static Future<int?> getUserIdFromToken() async {
    try {
      final token = await SharedPreferenceHelper.getString('token');

      if (token == null || token.isEmpty) {
        return null;
      }

      final response = await http.get(
        Uri.parse('$baseUrl/getUserId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['user_id'] != null) {
          return data['user_id'];
        } else {
          throw Exception('user_id not found in response');
        }
      } else {
        throw Exception('Failed to fetch user data: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching user ID: $e");
      return null;
    }
  }

  static Future<int?> getBookingId(int layananId) async {
    final token = await SharedPreferenceHelper.getString('token');

    if (token == null || token.isEmpty) {
      throw Exception("No token found. Please login first.");
    }

    final response = await http.get(
      Uri.parse('$baseUrl$getBookingIdEndpoint/$layananId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['booking_id'];
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Failed to fetch booking ID');
    }
  }

  Future<void> fetchBooking(String layananId) async {
    final token = await SharedPreferenceHelper.getString('token');

    if (token == null || token.isEmpty) {
      return null;
    }

    final url = Uri.parse('$baseUrl/api/booking/$layananId');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final bookingId = data['booking_id'];
      print('Booking found: $data');
    } else {
      final data = json.decode(response.body);
      print('Error: ${data['message']}');
    }
  }

  static Future<void> bookClass(int layananId) async {
    final token = await SharedPreferenceHelper.getString('token');
    if (token == null || token.isEmpty) {
      throw Exception('Token is missing or empty');
    }

    final url = Uri.parse('$baseUrl$createBookingEndpoint');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'layanan_id': layananId,
      }),
    );

    if (response.statusCode == 201) {
      final booking = json.decode(response.body);
      print("Booking berhasil: ${booking['id']}");
    } else {
      final errorMessage = json.decode(response.body)['message'];
      print("Error: $errorMessage");
      throw Exception('Failed to book class');
    }
  }

  static Future<Booking> getLatestBooking() async {
    final response =
        await http.get(Uri.parse('$baseUrl$getLatestBookingEndpoint'));

    if (response.statusCode == 200) {
      return Booking.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load latest booking');
    }
  }

  static Future<List<Layanan>> getUserBookings(String search) async {
    final token = await SharedPreferenceHelper.getString('token');

    if (token == null || token.isEmpty) {
      throw Exception("No token found. Please login first.");
    }

    final url =
        Uri.parse('http://10.0.2.2:8000/api/getBookedUser?search=$search');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      List<Layanan> bookings = jsonResponse.map((data) {
        return Layanan.fromJson(data['layanan']);
      }).toList();
      return bookings;
    } else {
      throw Exception('Failed to load bookings');
    }
  }

  static Future<http.Response> updateReminderTime(
      int layananId, String reminderTime) async {
    try {
      final token = await SharedPreferenceHelper.getString('token');

      if (token == null || token.isEmpty) {
        throw Exception("No token found. Please login first.");
      }

      final url =
          Uri.parse('http://10.0.2.2:8000/api/booking/$layananId/reminder');

      final body = json.encode({
        'reminder_time': reminderTime,
      });

      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: body,
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

  static Future<String?> getReminderTime(int layananId) async {
    try {
      final token = await SharedPreferenceHelper.getString('token');

      if (token == null || token.isEmpty) {
        throw Exception("No token found. Please login first.");
      }

      final response = await http.get(
        Uri.parse('$baseUrl/api/booking/$layananId/reminder'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data['reminder_time'];
      } else {
        print("Error: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error fetching reminder time: $e");
      return null;
    }
  }

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

  static Future<Map<String, dynamic>> cancelBooking(int bookingId) async {
    final token = await SharedPreferenceHelper.getString('token');

    if (token == null || token.isEmpty) {
      throw Exception("No token found. Please login first.");
    }

    final response = await http.delete(
      Uri.parse('$baseUrl$cancelBookingEndpoint/$bookingId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to cancel booking');
    }
  }

  static Future<Map<String, dynamic>> completeClass(int bookingId) async {
    final token = await SharedPreferenceHelper.getString('token');

    if (token == null || token.isEmpty) {
      throw Exception("No token found. Please login first.");
    }

    try {
      final response = await http.put(
        Uri.parse('$baseUrl/api/booking/complete-class/$bookingId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to complete class');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<List<Layanan>> getOrderedServices() async {
    final token = await SharedPreferenceHelper.getString('token');

    if (token == null || token.isEmpty) {
      throw Exception("No token found. Please login first.");
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/services/ordered'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((data) => Layanan.fromJson(data)).toList();
      } else {
        final errorMessage = json.decode(response.body)['message'];
        throw Exception('Failed to fetch ordered services: $errorMessage');
      }
    } catch (e) {
      print("Error fetching ordered services: $e");
      throw Exception("Error fetching ordered services: $e");
    }
  }
}
