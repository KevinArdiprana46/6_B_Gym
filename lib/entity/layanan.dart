class Layanan {
  final int id;
  final String className;
  final String timeStart;
  final String timeEnd;
  final String duration;
  final String burnedCalories;
  final String instructor;
  final double rating;
  final int reviews;
  final String description;
  final String state;
  final String imagePath;
  String reminderTime;
  final int availableSlots;
  final String classDate;

  Layanan({
    required this.id,
    required this.className,
    required this.timeStart,
    required this.timeEnd,
    required this.duration,
    required this.burnedCalories,
    required this.instructor,
    required this.rating,
    required this.reviews,
    required this.description,
    required this.state,
    required this.imagePath,
    required this.reminderTime,
    required this.availableSlots,
    required this.classDate,
  });

  // Mengubah JSON ke dalam bentuk objek Layanan
  factory Layanan.fromJson(Map<String, dynamic> json) {
    return Layanan(
      id: json['layanan_id'],
      className: json['class_name'],
      timeStart: json['time_start'],
      timeEnd: json['time_end'],
      duration: json['duration'],
      burnedCalories: json['burned_calories'],
      instructor: json['instructor'],
      rating: json['rating'].toDouble(),
      reviews: json['reviews'],
      description: json['description'],
      state: json['state'],
      imagePath: json['image_path'],
      reminderTime: json['reminder_time'],
      availableSlots: json['available_slots'],
      classDate: json['class_date'],
    );
  }

  // Mengubah objek Layanan ke dalam bentuk JSON
  Map<String, dynamic> toJson() {
    return {
      'layanan_id': id,
      'class_name': className,
      'time_start': timeStart,
      'time_end': timeEnd,
      'duration': duration,
      'burned_calories': burnedCalories,
      'instructor': instructor,
      'rating': rating,
      'reviews': reviews,
      'description': description,
      'state': state,
      'image_path': imagePath,
      'reminder_time': reminderTime,
      'available_slots': availableSlots,
      'class_date': classDate,
    };
  }
}
