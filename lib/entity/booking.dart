class Booking {
  final int bookingId;
  final int userId;
  final int layananId;
  final String bookingTime;
  final String reminderTime;
  final String state;

  Booking({
    required this.bookingId,
    required this.userId,
    required this.layananId,
    required this.bookingTime,
    required this.reminderTime,
    required this.state,
  });

  // Mengubah JSON ke dalam bentuk objek Booking
  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      bookingId: json['booking_id'],
      userId: json['user_id'],
      layananId: json['layanan_id'],
      bookingTime: json['booking_time'],
      reminderTime: json['reminder_time'],
      state: json['state'],
    );
  }

  // Mengubah objek Booking ke dalam bentuk JSON
  Map<String, dynamic> toJson() {
    return {
      'booking_id': bookingId,
      'user_id': userId,
      'layanan_id': layananId,
      'booking_time': bookingTime,
      'reminder_time': reminderTime,
      'state': state,
    };
  }
}
