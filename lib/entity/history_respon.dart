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
  String? namaDepan;
  Null? bookingTime;
  String? reminderTime;
  String? state;

  Data(
      {this.bookingId,
      this.className,
      this.namaDepan,
      this.bookingTime,
      this.reminderTime,
      this.state});

  Data.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    className = json['class_name'];
    namaDepan = json['nama_depan'];
    bookingTime = json['booking_time'];
    reminderTime = json['reminder_time'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_id'] = this.bookingId;
    data['class_name'] = this.className;
    data['nama_depan'] = this.namaDepan;
    data['booking_time'] = this.bookingTime;
    data['reminder_time'] = this.reminderTime;
    data['state'] = this.state;
    return data;
  }
}