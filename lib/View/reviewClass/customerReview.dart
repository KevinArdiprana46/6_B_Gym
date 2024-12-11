import 'package:flutter/material.dart';
import 'package:tubes_pbp_6/client/ReviewClient.dart'; // Pastikan path sesuai
import 'package:tubes_pbp_6/entity/review.dart'; // Entity untuk data review

class CustomerReview extends StatefulWidget {
  const CustomerReview({Key? key}) : super(key: key);

  @override
  _CustomerReviewState createState() => _CustomerReviewState();
}

class _CustomerReviewState extends State<CustomerReview> {
  late Future<List<review>> _reviewsFuture;

  @override
  void initState() {
    super.initState();
    _reviewsFuture = ReviewClient.getReviewsByIdLayanan(1); // ID layanan disesuaikan
  }

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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Customer Review',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF5565E8),
      ),
      body: FutureBuilder<List<review>>(
        future: _reviewsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Failed to load reviews: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No reviews available.'));
          }

          final reviews = snapshot.data!;
          return ListView.builder(
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              final review = reviews[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                elevation: 5,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  title: Text(
                    'Layanan ID: ${review.userId}', // Ganti sesuai data layanan
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
          );
        },
      ),
    );
  }
}
