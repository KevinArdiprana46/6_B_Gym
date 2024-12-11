import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tubes_pbp_6/entity/payment_respon.dart';
import 'package:tubes_pbp_6/helper/shared_preference.helper.entity.dart';

class PaymentClient {
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  static Future<List<Map<String, dynamic>>> getPayments() async {
    try {
      final token = await SharedPreferenceHelper.getString('token');

      final response = await http.get(
        Uri.parse('$baseUrl/payments'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((payment) => {
              'payment_id': payment['payment_id'],
              'transaction_date': payment['transaction_date'],
              'transaction_time': payment['transaction_time'],
              'booking_id': payment['booking_id'],
              'status': payment['status'],
            }).toList();
      } else {
        throw Exception('Failed to fetch payments: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching payments: $e');
      return [];
    }
  }

  static Future<Map<String, dynamic>> getPaymentById(int paymentId) async {
    try {
      final token = await SharedPreferenceHelper.getString('token');

      final response = await http.get(
        Uri.parse('$baseUrl/payments/$paymentId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          'payment_id': data['payment_id'],
          'transaction_date': data['transaction_date'],
          'transaction_time': data['transaction_time'],
          'booking_id': data['booking_id'],
          'status': data['status'],
        };
      } else {
        throw Exception('Failed to fetch payment details: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching payment details: $e');
      throw Exception('Failed to fetch payment details');
    }
  }

  static Future<Payment> createPayment({
    required int layananId,
    required String status,
  }) async {
    try {
      final token = await SharedPreferenceHelper.getString('token');

      final response = await http.post(
        Uri.parse('$baseUrl/payments'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'layanan_id': layananId,
          'status': status,
        }),
      );
      print(response.body);

      if (response.statusCode == 201) {
        
        final data = await PaymentResponse.fromJson(json.decode(response.body));
       return data.payment!;
      } else {
        throw Exception('Failed to create payment: ${response.statusCode}');
      }
    } catch (e) {
      print('Error creating payment: $e');
      throw Exception('Failed to create payment');
    }
  }
}
