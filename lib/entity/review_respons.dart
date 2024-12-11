class ReviewRespon {
  bool? success;
  List<Data>? data;

  ReviewRespon({this.success, this.data});

  ReviewRespon.fromJson(Map<String, dynamic> json) {
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
  int? reviewId;
  int? userId;
  int? rating;
  String? komentar;
  String? tanggalReview;
  String? createdAt;
  String? updatedAt;
  int? layananId;

  Data(
      {this.reviewId,
      this.userId,
      this.rating,
      this.komentar,
      this.tanggalReview,
      this.createdAt,
      this.updatedAt,
      this.layananId});

  Data.fromJson(Map<String, dynamic> json) {
    reviewId = json['review_id'];
    userId = json['user_id'];
    rating = json['rating'];
    komentar = json['komentar'];
    tanggalReview = json['tanggal_review'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    layananId = json['layanan_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['review_id'] = this.reviewId;
    data['user_id'] = this.userId;
    data['rating'] = this.rating;
    data['komentar'] = this.komentar;
    data['tanggal_review'] = this.tanggalReview;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['layanan_id'] = this.layananId;
    return data;
  }
}
