class HistoryRespon {
  bool? success;
  List<Data>? data;

  HistoryRespon({this.success, this.data});

  HistoryRespon.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? bookingId;
  String? className;
  int? layanan_id;
  String? namaDepan;
  Null? bookingTime;
  String? reminderTime;
  String? state;
  int? user_id;

  Data(
      {this.bookingId,
      this.className,
      this.namaDepan,
      this.bookingTime,
      this.reminderTime,
      this.layanan_id,
      this.user_id,
      this.state});

  Data.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    className = json['class_name'];
    namaDepan = json['nama_depan'];
    layanan_id = json['layanan_id'];
    bookingTime = json['booking_time'];
    reminderTime = json['reminder_time'];
    state = json['state'];
    user_id= json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_id'] = this.bookingId;
    data['class_name'] = this.className;
    data['layanan_id'] = this.layanan_id;
    data['nama_depan'] = this.namaDepan;
    data['booking_time'] = this.bookingTime;
    data['reminder_time'] = this.reminderTime;
    data['state'] = this.state;
    return data;
  }
}
