class review {
  int? userId;
  int? rating;
  String? komentar;
  String? tanggalReview;
  String? updatedAt;
  String? createdAt;
  int? reviewId;

  review(
      {this.userId,
      this.rating,
      this.komentar,
      this.tanggalReview,
      this.updatedAt,
      this.createdAt,
      this.reviewId});

  review.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    rating = json['rating'];
    komentar = json['komentar'];
    tanggalReview = json['tanggal_review'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    reviewId = json['review_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['rating'] = this.rating;
    data['komentar'] = this.komentar;
    data['tanggal_review'] = this.tanggalReview;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['review_id'] = this.reviewId;
    return data;
  }
}
