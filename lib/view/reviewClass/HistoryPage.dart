import 'package:flutter/material.dart';
import 'package:tubes_pbp_6/view/reviewClass/reviewPage.dart';
import 'package:tubes_pbp_6/data/data.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5565E8),
        title: const Text(
          'History Layanan',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: reviewData.length,
        itemBuilder: (context, index) {
          final review = reviewData[index];
          return ListTile(
            leading: Image.asset(
              review.layanan.classImage,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(review.layanan.namaLayanan),
            subtitle: Text('Selesai: ${review.layanan.jadwal}'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReviewPage(
                    selectedService: review.layanan,
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
