import 'package:flutter/material.dart';
import 'package:tubes_pbp_6/entity/layanan.dart';

class InvoicePage extends StatelessWidget {
  final Layanan layanan;

  const InvoicePage({Key? key, required this.layanan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const int fixedPrice = 750000; // Harga tetap
    const int taxAmount = 7500; // Pajak tetap
    const int adminFees = 2500; // Admin fee tetap
    const int totalAmount = fixedPrice + taxAmount + adminFees; // Total

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Icon(Icons.check_circle, size: 80, color: Colors.green),
            const SizedBox(height: 16),
            const Text(
              'Payment Success',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "IDR $fixedPrice",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Payment ID'),
                      Text('71289462', style: TextStyle(color: Colors.black)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Transaction Date'),
                      Text(
                        'June 15 2024',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Transaction Time'),
                      Text(
                        '20:35:38 WIB',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.black, thickness: 0.5),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Payer Name'),
                      Text(
                        'Fahmy Junaedi',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Debit Account'),
                      Text(
                        '07283475',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.black, thickness: 0.5),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Nominal'),
                      Text(
                        'IDR $fixedPrice',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Tax'),
                      Text(
                        'IDR $taxAmount',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Admin Fees'),
                      Text(
                        'IDR $adminFees',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.black, thickness: 0.5),
                  const SizedBox(height: 8),
                  const Text(
                    'Your class will be reminded to you at 15:00',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Logika untuk mencetak invoice
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Invoice printed successfully!")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Print Invoice',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(
                      context, ModalRoute.withName('/')); // Kembali ke home
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Back To Home',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
