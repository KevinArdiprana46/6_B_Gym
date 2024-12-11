import 'package:flutter/material.dart';
import 'package:tubes_pbp_6/client/ReviewClient.dart';
import 'package:tubes_pbp_6/entity/review.dart';

class ReviewClassPage extends StatefulWidget {
  final int userId;
  final int classId;

  const ReviewClassPage({Key? key, required this.userId, required this.classId}) : super(key: key);

  @override
  _ReviewClassPageState createState() => _ReviewClassPageState();
}

class _ReviewClassPageState extends State<ReviewClassPage> {
  int _rating = 0;
  String _reviewText = '';

  // Submit review to the database
  void _submitReview() async {
    final reviewData = review(
      userId: widget.userId,
      rating: _rating,
      komentar: _reviewText,
      tanggalReview: DateTime.now().toIso8601String(),
    );

    try {
      await ReviewClient.addReview(widget.classId, reviewData); // Create new review using static method
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Review submitted successfully')),
      );

      // Optionally navigate back or show another success action
      await Future.delayed(const Duration(seconds: 2));
      Navigator.pop(context); // Navigate back to the previous screen after submission
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit review: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5565E8),
        title: const Text('Review Class', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Rate this class and leave a comment',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _rating = index + 1;
                    });
                  },
                  child: Icon(
                    index < _rating ? Icons.star : Icons.star_border,
                    size: 30,
                    color: Colors.amber,
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            TextField(
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Write your review...',
              ),
              onChanged: (value) {
                _reviewText = value;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitReview,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5565E8),
              ),
              child: const Text('Submit Review'),
            ),
          ],
        ),
      ),
    );
  }
}
