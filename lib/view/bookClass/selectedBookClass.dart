import 'package:flutter/material.dart';
import 'package:tubes_pbp_6/entity/booking.dart'; // Import entity Booking
import 'package:tubes_pbp_6/client/bookingClient.dart'; // Import client BookingClient
import 'package:tubes_pbp_6/helper/shared_preference.helper.entity.dart';
import 'dart:convert';

import 'package:tubes_pbp_6/view/bookClass/booking.dart';

class SelectedClassBook extends StatelessWidget {
  final String className;
  final String timeStart;
  final String timeEnd;
  final String imagePath;
  final Map<String, dynamic> details;
  final Function(String) onBook;
  final Function(String) onCancel;

  const SelectedClassBook({
    Key? key,
    required this.className,
    required this.timeStart,
    required this.timeEnd,
    required this.imagePath,
    required this.details,
    required this.onBook,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String state = details['state'] ?? 'available';

    // Fungsi untuk memesan kelas
    // Fungsi untuk memesan kelas, dipanggil saat tombol booking ditekan
    void _bookClass() async {
      try {
        // Ambil layanan_id dari details
        final layananId = details['layanan_id']; // Pastikan ini integer

        if (layananId == null) {
          throw Exception('Layanan ID not found');
        }

        // Panggil fungsi untuk melakukan booking
        await BookingClient.bookClass(layananId);

        // Tampilkan SnackBar jika booking berhasil
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Class successfully booked!')),
        );

        // Kembali ke halaman sebelumnya setelah booking berhasil
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>  BookClass()));
      } catch (e) {
        // Tampilkan pesan error jika terjadi kesalahan
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 85, 101, 232),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Class Details',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Class image
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Class details and description
            Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      className,
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.access_time, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(
                        "Time: $timeStart - $timeEnd",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.local_fire_department,
                          color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(
                        "Burned Calories: ${details['burned_calories']}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.person, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(
                        "Instructor: ${details['instructor']}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      const Text(
                        "Rating:",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            Icons.star,
                            color: index < (details['rating'] as double).toInt()
                                ? Colors.amber
                                : Colors.grey,
                            size: 20,
                          );
                        }),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "(${details['reviews']})",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Text(
                    details['description'],
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  // Conditional Button for "Order Class" or "Cancel Order"
                  Center(
                    child: state == 'booked'
                        ? const SizedBox() // Do nothing if the class is booked
                        : ElevatedButton(
                            onPressed: () {
                              if (state == 'available') {
                                _bookClass(); // Call the function to book the class
                              } else if (state == 'ordered') {
                                onCancel(details['className']);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: state == 'ordered'
                                  ? Colors.red
                                  : const Color.fromARGB(255, 85, 101, 232),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 100,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              state == 'ordered'
                                  ? "Cancel Order"
                                  : "Order Class",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
