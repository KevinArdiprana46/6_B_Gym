import 'package:tubes_pbp_6/entity/user.dart';

class Loginresponse {
  String? message;
  User? user;
  String? token;

  Loginresponse({this.message, this.user, this.token});

  Loginresponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

