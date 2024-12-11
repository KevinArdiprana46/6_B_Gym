import 'dart:convert';

class review {
  int? userId;
  int? layanan_id;
  int? rating;
  String? komentar;
  String? tanggalReview;
  String? updatedAt;
  String? createdAt;
  int? reviewId;

  review(
      {
       this.userId,
      this.rating,
      this.layanan_id,
      this.komentar,
      this.tanggalReview,
      this.updatedAt,
      this.createdAt,
      this.reviewId});

  review.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    layanan_id = json['layanan_id'];
    rating = json['rating'];
    komentar = json['komentar'];
    tanggalReview = json['tanggal_review'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    reviewId = json['review_id'];
  }

  Map<String, dynamic> toJson() {
     return {
      'user_id': userId,
      'layanan_id': layanan_id,
      'rating': rating,
      'komentar': komentar,
      'tanggal_review': tanggalReview,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'review_id': reviewId,
    };
  }

  String toRawJson() => json.encode(toJson());
}
