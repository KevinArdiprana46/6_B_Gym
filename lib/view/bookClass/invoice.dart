import 'package:flutter/material.dart';
import 'package:tubes_pbp_6/entity/layanan.dart';
import 'package:tubes_pbp_6/entity/payment_respon.dart';
import 'package:tubes_pbp_6/view/bookClass/booking.dart';

class InvoicePage extends StatelessWidget {
  final Layanan layanan;
  final Payment paymentDetails;

  const InvoicePage({Key? key, required this.layanan, required this.paymentDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const int fixedPrice = 750000;
    const int taxAmount = 7500;
    const int adminFees = 2500;
    const int totalAmount = fixedPrice + taxAmount + adminFees;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
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
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 8),
            Text(
              "IDR $totalAmount",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
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
                      Text(paymentDetails.paymentId.toString(),
                          style: const TextStyle(color: Colors.black)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Transaction Date'),
                      Text(paymentDetails.paymentDate.toString(),
                          style: const TextStyle(color: Colors.black)),
                    ],
                  ),
                  const Divider(color: Colors.black, thickness: 0.5),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Nominal'),
                      Text(
                        'IDR $fixedPrice',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Tax'),
                      Text(
                        'IDR $taxAmount',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Admin Fees'),
                      Text(
                        'IDR $adminFees',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, 
                  MaterialPageRoute(builder: (context) => BookClass()));
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
