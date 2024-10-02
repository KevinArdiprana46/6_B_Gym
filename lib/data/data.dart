class dataLayanan{
  final String namaLayanan;
  final String deskripsi;
  final String jadwal;
  dataLayanan(this.namaLayanan, this.deskripsi, this.jadwal);
}

final List<dataLayanan> data =
  _data.map((e) => dataLayanan(e['namaLayanan'] as String, e['deskripsi'] as String, e['jadwal'] as String)).toList(growable: false);

final List<Map<String, Object>> _data =
[
  {
    "namaLayanan": "Kelas Kardio",
    "deskripsi" : "Kelas Kardio untuk kesehatan jantung dan membakar lemak",
    "jadwal": "Setiap Selasa"
  },
  {
    "namaLayanan": "Kelas Angkat Beban",
    "deskripsi" : "Membangun Massa Otot",
    "jadwal": "Setiap Kamis"
  },
  {
    "namaLayanan": "Kelas Yoga",
    "deskripsi" : "Membangun ketenangan jiwa",
    "jadwal": "Setiap Minggu"
  }
];
