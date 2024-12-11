import 'package:flutter/material.dart';
import 'package:tubes_pbp_6/client/paymentClient.dart';
import 'package:tubes_pbp_6/entity/layanan.dart';
import 'package:tubes_pbp_6/view/bookClass/invoice.dart';

class PaymentMethodPage extends StatelessWidget {
  final Layanan layanan;

  const PaymentMethodPage({Key? key, required this.layanan}) : super(key: key);

  Future<void> _createPayment(BuildContext context) async {
    try {
      final payment = await PaymentClient.createPayment(
        layananId: layanan.id,
        status: "paid",
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Payment Successful!")),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InvoicePage(
            layanan: layanan,
            paymentDetails: payment,
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Payment failed: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const int fixedPrice = 700000;
    const int taxAmount = 7000;
    const int totalAmount = 707000;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Total',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  layanan.className,
                  style: const TextStyle(fontSize: 16),
                ),
                const Text(
                  "IDR $fixedPrice",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tax', style: TextStyle(color: Colors.red)),
                Text('1% IDR $taxAmount', style: TextStyle(color: Colors.red)),
              ],
            ),
            const Divider(thickness: 1, height: 32),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Amount',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "IDR $totalAmount",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              'Payment Method',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'images/qrisLogo.jpg', 
                    width: 100,
                    height: 50,
                  ),
                  const SizedBox(height: 16),
                  Image.asset(
                    'images/qrCode.jpg', 
                    width: 200,
                    height: 200,
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _createPayment(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Proceed to Payment',
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
