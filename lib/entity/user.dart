import 'dart:convert';

class User {
  int user_id;
  String nama_depan;
  String nama_belakang;
  String password;
  String email;
  String profile_picture;
  String tanggal_lahir;
  String jenis_kelamin;
  String nomor_telepon;
  int weight;
  int height;

  User(
      {required this.user_id,
      required this.nama_depan,
      required this.nama_belakang,
      required this.password,
      required this.email,
      required this.profile_picture,
      required this.tanggal_lahir,
      required this.jenis_kelamin,
      required this.nomor_telepon,
      required this.height,
      required this.weight});

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));
  factory User.fromJson(Map<String, dynamic> json) => User(
      user_id: json["user_id"] ?? '',
      nama_depan: json["nama_depan"],
      nama_belakang: json["nama_belakang"],
      password: json["password"] ?? '',
      email: json["email"],
      profile_picture: json["profile_picture"] ?? '',
      tanggal_lahir: json["tanggal_lahir"],
      jenis_kelamin: json["jenis_kelamin"],
      nomor_telepon: json["nomor_telepon"],
      weight: json["weight"],
      height: json["height"]);

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
      "nama_depan": nama_depan,
      "nama_belakang": nama_belakang,
      "password": password,
      "email": email,
      "profile_picture": profile_picture,
      "tanggal_lahir": tanggal_lahir,
      "jenis_kelamin": jenis_kelamin,
      "nomor_telepon": nomor_telepon,
      "weight": weight,
      "height": height,
    };
}
