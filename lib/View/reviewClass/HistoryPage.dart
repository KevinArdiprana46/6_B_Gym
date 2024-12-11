import 'package:flutter/material.dart';
import 'package:tubes_pbp_6/client/historyClient.dart';
import 'package:tubes_pbp_6/entity/history_respon.dart';
import 'package:tubes_pbp_6/view/reviewClass/reviewClassPage.dart'; // Pastikan import halaman review

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late Future<HistoryRespon> _historyFuture;

  @override
  void initState() {
    super.initState();
    _historyFuture = HistoryClient.getCompletedBookings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5565E8),
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
      body: FutureBuilder<HistoryRespon>(
        future: _historyFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
            return const Center(
              child: Text('Tidak ada layanan yang telah selesai.'),
            );
          } else {
            final histories = snapshot.data!;
            return ListView.builder(
              itemCount: histories.data!.length,
              itemBuilder: (context, index) {
                final history = histories.data![index];

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: Icon(
                      Icons.class_,
                      color: Colors.blue[800],
                    ),
                  ),
                  title: Text(
                    history.className!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Selesai: ${history.bookingTime}', // Tampilkan tanggal yang diformat
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () async {
                    // Ambil userId dari SharedPreferences atau API sesuai kebutuhan
                    int userId = 123; // Contoh userId (pastikan kamu mengambilnya secara dinamis)

                    // Navigasi ke ReviewClassPage dan kirimkan userId serta classId
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReviewClassPage(
                          userId: history.user_id!,  // Kirimkan userId yang sesuai
                          classId: history.bookingId!, 
                          layanan_id: history.layanan_id!, // Kirimkan classId dari history
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
