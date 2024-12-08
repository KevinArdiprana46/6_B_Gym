import 'dart:convert';

class Profile {
  int? profile_id;
  String? nama_depan;
  String? nama_belakang;
  String? password;
  final dynamic tanggal_lahir;
  int? height;
  int? weight;
  String? email;
  String? nomor_telepon;
  String? jenis_kelamin;
  String? profile_picture;

  Profile({
    this.profile_id,
    this.nama_depan,
    this.nama_belakang,
    this.password,
    this.tanggal_lahir,
    this.height,
    this.weight,
    this.email,
    this.nomor_telepon,
    this.jenis_kelamin,
    this.profile_picture,
  });

  // Konversi dari JSON ke Profile
  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      profile_id: json['profile_id'],
      nama_depan: json['nama_depan'],
      nama_belakang: json['nama_belakang'],
      email: json['email'],
      nomor_telepon: json['nomor_telepon'],
      password: json['password'],
      tanggal_lahir: json['tanggal_lahir'],
      height: json['height'],
      weight: json['weight'],
      jenis_kelamin: json['jenis_kelamin'],
      profile_picture: json['profile_picture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama_depan': nama_depan,
      'nama_belakang': nama_belakang,
      'email': email,
      'nomor_telepon': nomor_telepon,
      'password': password,
      'tanggal_lahir': tanggal_lahir,
      'height': height,
      'weight': weight,
      'jenis_kelamin': jenis_kelamin,
      'profile_picture': profile_picture,
    };
  }

  String toRawJson() => json.encode(toJson());
}
