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
