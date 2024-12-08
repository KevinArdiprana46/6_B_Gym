import 'package:flutter/material.dart';
import 'payment.method.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PreviewPage(),
    );
  }
}

class PreviewPage extends StatefulWidget {
  @override
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  final List<String> items = ['Aerobic', 'Boxing', 'Lifting'];
  final List<String> images = [
    'images/aerobic.jpg', // Gambar pertama
    'images/boxing.jpg',  // Gambar kedua
    'images/lifting.jpg'  // Gambar ketiga
  ];
  
  List<bool> selectedItems = [false, false, false]; // Menyimpan status checkbox
  bool selectAll = false; // Status untuk Select All

  // Fungsi untuk memperbarui status item tertentu
  void updateItemSelection(int index, bool value) {
    setState(() {
      selectedItems[index] = value; // Perbarui status checkbox item
      selectAll = selectedItems.every((item) => item); // Periksa apakah semua dipilih
    });
  }

  // Fungsi untuk memperbarui status Select All
  void updateSelectAll(bool value) {
    setState(() {
      selectAll = value; // Jika null, set false
      for (int i = 0; i < selectedItems.length; i++) {
        selectedItems[i] = selectAll; // Set semua item sesuai dengan status Select All
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Cart', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Navigasi kembali
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      Checkbox(
                        value: selectedItems[index],
                        onChanged: (bool? value) {
                          updateItemSelection(index, value!); // Memperbarui status checkbox item
                        },
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                images[index],
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.black.withOpacity(0.4),
                              ),
                            ),
                            Positioned(
                              bottom: 16,
                              left: 16,
                              child: Text(
                                items[index],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: selectAll,
                      onChanged: (bool? value) {
                        updateSelectAll(value!); // Memperbarui status Select All
                      },
                    ),
                    Text(
                      'Select All',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigasi ke halaman PaymentMethodPage saat tombol Payment ditekan
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PaymentMethodPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                  ),
                  child: Text('Payment'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
