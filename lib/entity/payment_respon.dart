class PaymentResponse {
  String? message;
  Payment? payment;

  PaymentResponse({this.message, this.payment});

  PaymentResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    payment = json['payment'] != null ? Payment.fromJson(json['payment']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (payment != null) {
      data['payment'] = payment!.toJson();
    }
    return data;
  }
}

class Payment {
  int? bookingId;
  String? status;
  String? paymentDate;
  String? updatedAt;
  String? createdAt;
  int? paymentId;

  Payment({
    this.bookingId,
    this.status,
    this.paymentDate,
    this.updatedAt,
    this.createdAt,
    this.paymentId,
  });

  Payment.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    status = json['status'];
    paymentDate = json['payment_date'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    paymentId = json['payment_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['booking_id'] = bookingId;
    data['status'] = status;
    data['payment_date'] = paymentDate;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['payment_id'] = paymentId;
    return data;
  }
}
