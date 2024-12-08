import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InvoicePage(),
    );
  }
}

class InvoicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Text(
                  'INVOICE',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Spacer(),
                Image.asset(
                  'images/image.png',
                  height: 40,
                ),
              ],
            ),
            SizedBox(height: 16),
            // TO, DATE, INVOICE NO
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TO:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('Fahmy Junaedi'),
                    Text('fahmy8384@gmail.com'),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'DATE:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('June 15 2024'),
                    SizedBox(height: 8),
                    Text(
                      'NO INVOICE:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('71289462'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 32),
            // Item Table
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('ITEM', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('PRICE', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('QTY', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('TOTAL', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Aerobic Class 1 Month'),
                      Text('IDR 750.000'),
                      Text('1'),
                      Text('IDR 750.000'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Payment Info
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('SUB TOTAL', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('IDR 750.000'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('FEE', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('IDR 7.500'),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('IDR 757.500'),
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),
            // Signature and Footer
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'THANK YOU FOR YOUR TRANSACTION',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Aaron Panji'),
                    SizedBox(width: 8),
                    Container(
                      height: 2,
                      width: 50,
                      color: Colors.black,
                    ),
                  ],
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Download',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Back To Home',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
