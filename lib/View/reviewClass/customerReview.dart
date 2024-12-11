import 'package:flutter/material.dart';
import 'package:tubes_pbp_6/client/ReviewClient.dart'; // Pastikan path sesuai
import 'package:tubes_pbp_6/entity/review.dart';
import 'package:tubes_pbp_6/entity/review_respons.dart'; // Entity untuk data review

class CustomerReview extends StatefulWidget {
  const CustomerReview({Key? key}) : super(key: key);

  @override
  _CustomerReviewState createState() => _CustomerReviewState();
}

class _CustomerReviewState extends State<CustomerReview> {
  late Future<ReviewRespon> _reviewsFuture;  // Tidak diperlukan lagi, karena langsung di-fetch dalam `initState`
  late List<Data> _reviews = [];  // Menyimpan data review

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // Method untuk mengambil data
  void fetchData() async {
    try {
      final data = await ReviewClient.getAll(); // Menunggu data dari client
      setState(() {
        _reviews = data.data!;  // Menyimpan data reviews yang di-fetch
      });
    } catch (e) {
      // Menangani error jika gagal mengambil data
      print("Error fetching data: $e");
    }
  }

  // Fungsi untuk membangun bintang rating
  List<Widget> buildStars(int rating) {
    List<Widget> stars = [];
    for (int i = 1; i <= 5; i++) {
      stars.add(
        Icon(
          i <= rating ? Icons.star : Icons.star_border,
          color: Colors.yellow,
          size: 20,
        ),
      );
    }
    return stars;
  }

  @override
  Widget build(BuildContext context) {
    // Memastikan data sudah di-load sebelum membangun UI
    if (_reviews.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Customer Review',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xFF5565E8),
        ),
        body: const Center(child: CircularProgressIndicator()), // Menunggu data
      );
    }

    // Setelah data berhasil di-load, tampilkan UI
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Customer Review',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF5565E8),
      ),
      body: ListView.builder(
        itemCount: _reviews.length,
        itemBuilder: (context, index) {
          final review = _reviews[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            elevation: 5,
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              title: Text(
                'Layanan ID: ${review.layananId}', // Ganti sesuai data layanan
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reviewed by User ID: ${review.userId}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: buildStars(review.rating ?? 0),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    review.komentar ?? '',
                    style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 10),
                  // Placeholder untuk gambar layanan atau trainer
                  Container(
                    color: Colors.grey[200],
                    width: 100,
                    height: 100,
                    child: const Center(child: Text('No Image')),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
