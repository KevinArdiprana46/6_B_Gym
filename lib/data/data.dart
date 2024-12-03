import 'package:flutter/material.dart';

class dataLayanan {
  final String namaLayanan;
  final String deskripsi;
  final String jadwal;
  final String trainerImage;
  final String classImage;

  dataLayanan(
    this.namaLayanan,
    this.deskripsi,
    this.jadwal,
    this.trainerImage,
    this.classImage,
  );
}

final List<dataLayanan> data = _data.map(
  (e) => dataLayanan(
    e['namaLayanan'] as String,
    e['deskripsi'] as String,
    e['jadwal'] as String,
    e['trainerImage'] as String,
    e['classImage'] as String,
  ),
).toList(growable: false);

final List<Map<String, Object>> _data = [
  {
    "namaLayanan": "Kelas Kardio",
    "deskripsi": "Kelas Kardio untuk kesehatan jantung dan membakar lemak",
    "jadwal": "Setiap Selasa",
    "trainerImage": "lib/assets/trainer.png",
    "classImage": "lib/assets/gym.jpg",
  },
  {
    "namaLayanan": "Kelas Angkat Beban",
    "deskripsi": "Membangun Massa Otot",
    "jadwal": "Setiap Kamis",
    "trainerImage": "lib/assets/class.png",
    "classImage": "lib/assets/gym.jpg",
  },
  {
    "namaLayanan": "Kelas Yoga",
    "deskripsi": "Membangun ketenangan jiwa",
    "jadwal": "Setiap Minggu",
    "trainerImage": "lib/assets/class.png",
    "classImage": "lib/assets/class.png",
  },
  {
    "namaLayanan": "Boxing",
    "deskripsi": "Kelas Boxing untuk latihan intens",
    "jadwal": "Setiap Sabtu",
    "trainerImage": "lib/assets/class.png",
    "classImage": "lib/assets/trainer.png",
  },
];

class ReviewData {
  final dataLayanan layanan;  
  final double rating;  
  final String review; 
  final String reviewerName; 

  ReviewData({
    required this.layanan,
    required this.rating,
    required this.review,
    required this.reviewerName,
  });
}


final List<ReviewData> reviewData = [
  ReviewData(
    layanan: data[0],
    rating: 4.5,
    review: "Kelas yang sangat membantu dalam membakar lemak dan menjaga kesehatan jantung.",
    reviewerName: "Arianto",
  ),
  ReviewData(
    layanan: data[1],
    rating: 5.0,
    review: "Latihan angkat beban yang menantang dan efektif untuk membentuk massa otot.",
    reviewerName: "Budi",
  ),
  ReviewData(
    layanan: data[2], 
    rating: 4.0,
    review: "Kelas yoga ini sangat menenangkan, namun bisa lebih banyak variasi pose.",
    reviewerName: "Siti",
  ),
  ReviewData(
    layanan: data[3],
    rating: 4.7,
    review: "Latihan boxing yang intens, cocok untuk meningkatkan ketahanan dan kekuatan.",
    reviewerName: "Andi",
  ),
];
