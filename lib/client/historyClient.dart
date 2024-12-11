import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tubes_pbp_6/entity/history_respon.dart';
import 'package:tubes_pbp_6/helper/shared_preference.helper.entity.dart';

class HistoryClient {
  static const String baseUrl = 'http://10.0.2.2:8000';

  static const String getCompletedBookingsEndpoint = '/history/complete';

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
      print('Error: ${response.statusCode}');
      print('Response Body: ${response.body}');
      throw Exception('Failed to fetch user data: ${response.statusCode}');
    }
  } catch (e) {
    print("Error fetching user ID: $e");
    return null;
  }
}

static Future<HistoryRespon> getCompletedBookings() async {
 
  final token = await SharedPreferenceHelper.getString('token');

  if (token == null || token.isEmpty) {
    throw Exception("No token found. Please login first.");
  }
print(token);
  // Gunakan endpoint yang sudah didefinisikan
  final url = Uri.parse('$baseUrl/api$getCompletedBookingsEndpoint'); // gunakan getCompletedBookingsEndpoint
  print('url ${url}');
  try {
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
print(response.body);
    if (response.statusCode == 200) {
      final res = HistoryRespon.fromJson(jsonDecode(response.body));
      print(res.data![0].bookingId);
      return res;
    } else {
      print('Error: ${response.statusCode}');
      print('Response Body: ${response.body}');
      throw Exception('Failed to load completed bookings');
    }
  } catch (e) {
    print('Error in getCompletedBookings: $e');
    rethrow;
  }
}


// Future<void> loadCompletedBookings() async {
//   try {
//     List<History> completedBookings = await HistoryClient.getCompletedBookings();
    
//     // Menampilkan data jika berhasil
//     completedBookings.forEach((booking) {
//       print('Booking ID: ${booking.bookingId}');
//       print('Class Name: ${booking.className}');
//       print('First Name: ${booking.firstName}');
//       print('Booking Time: ${booking.bookingTime}');
//       print('Reminder Time: ${booking.reminderTime}');
//       print('State: ${booking.state}');
//     });
//   } catch (e) {
//     print('Error fetching completed bookings: $e');
//   }
// }

}
