class Booking {
  final int userId;
  final int layananId;

  Booking({required this.userId, required this.layananId});

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'layanan_id': layananId,
    };
  }

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      userId: json['user_id'],
      layananId: json['layanan_id'],
    );
  }
}
