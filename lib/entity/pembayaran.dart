class Pembayaran {
  final int paymentId;
  final int bookingId;
  final double amount;
  final String status;
  final DateTime paymentDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  Pembayaran({
    required this.paymentId,
    required this.bookingId,
    required this.amount,
    required this.status,
    required this.paymentDate,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory untuk membuat objek dari JSON
  factory Pembayaran.fromJson(Map<String, dynamic> json) {
    return Pembayaran(
      paymentId: json['payment_id'],
      bookingId: json['booking_id'],
      amount: json['amount'].toDouble(),
      status: json['status'],
      paymentDate: DateTime.parse(json['payment_date']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  // Method untuk mengonversi objek ke JSON
  Map<String, dynamic> toJson() {
    return {
      'payment_id': paymentId,
      'booking_id': bookingId,
      'amount': amount,
      'status': status,
      'payment_date': paymentDate.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // Override toString untuk debugging
  @override
  String toString() {
    return 'Pembayaran(paymentId: $paymentId, bookingId: $bookingId, amount: $amount, status: $status, paymentDate: $paymentDate, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
