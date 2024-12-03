import 'dart:convert';

class Profile {
  String? nama_depan;
  String? nama_belakang;
  String? password;
  String? tanggal_lahir;
  double? height;
  double? weight;
  String? email;
  String? nomor_telepon;
  String? jenis_kelamin;
  String? profile_picture;

  Profile({
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

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      nama_depan: json['nama_depan'],
      nama_belakang: json['nama_belakang'],
      password: json['password'],
      tanggal_lahir: json['tanggal_lahir'],
      height: (json['height'] != null) ? double.tryParse(json['height'].toString()) : null,
      weight: (json['weight'] != null) ? double.tryParse(json['weight'].toString()) : null,
      email: json['email'],
      nomor_telepon: json['nomor_telepon'],
      jenis_kelamin: json['jenis_kelamin'],
      profile_picture: json['profile_picture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama_depan': nama_depan,
      'nama_belakang': nama_belakang,
      'password': password,
      'tanggal_lahir': tanggal_lahir,
      'height': height,
      'weight': weight,
      'email': email,
      'phone': nomor_telepon,
      'gender': jenis_kelamin,
      'profile_picture': profile_picture,
    };
  }

  String toRawJson() => json.encode(toJson());
}


