import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const SizedBox kSizeBox2 = SizedBox(width: 10); 
const TextStyle kTextStyle3 = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 50),
                child: Row(
                  children: [
                    kSizeBox2,
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('images/download.jpg'),
                    ),
                    kSizeBox2,
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Aku Manusia Sehat'),
                          Text('Sehat'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Text('Berat Badan', style: kTextStyle3),
                          const Text('80', style: kTextStyle3),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Text('Tinggi Badan', style: kTextStyle3),
                          const Text('180', style: kTextStyle3),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Text('Riwayat Sakit', style: kTextStyle3),
                          const Text('-', style: kTextStyle3),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
