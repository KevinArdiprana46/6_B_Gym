import 'package:flutter/material.dart';
import 'package:tubes_pbp_6/data/data.dart'; 

class CustomerReview extends StatelessWidget {
  const CustomerReview({Key? key}) : super(key: key);


  List<Widget> buildStars(double rating) {
    List<Widget> stars = [];
    for (int i = 1; i <= 5; i++) {
      if (i <= rating) {
        stars.add(const Icon(
          Icons.star,
          color: Colors.yellow,
          size: 20,
        ));
      } else {
        stars.add(const Icon(
          Icons.star_border,
          color: Colors.yellow,
          size: 20,
        ));
      }
    }
    return stars;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Customer Review',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF5565E8),
      ),
      body: ListView.builder(
        itemCount: reviewData.length, 
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            elevation: 5,
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              title: Text(
                reviewData[index].layanan.namaLayanan,  
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reviewed by: ${reviewData[index].reviewerName}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: buildStars(reviewData[index].rating), 
                  ),
                  const SizedBox(height: 5),
                  Text(
                    reviewData[index].review,
                    style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 10),
                  Image.asset(
                    reviewData[index].layanan.classImage, 
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 5),
                  Image.asset(
                    reviewData[index].layanan.trainerImage, 
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
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
