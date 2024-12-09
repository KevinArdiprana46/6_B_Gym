import 'package:flutter/material.dart';
import 'package:tubes_pbp_6/client/bookingClient.dart';
import 'package:tubes_pbp_6/entity/layanan.dart';
import 'package:tubes_pbp_6/view/bookClass/changeReminder.dart';

class NotificationBooking extends StatefulWidget {
  // final List<Layanan> bookedClasses;

  // const NotificationBooking({
  //   Key? key,
  //   required this.bookedClasses,
  // }) : super(key: key);
  const NotificationBooking({Key? key}) : super(key: key);

  @override
  _NotificationBookingState createState() => _NotificationBookingState();
}

class _NotificationBookingState extends State<NotificationBooking> {
  late TextEditingController _searchController;
  late List<Layanan> _allClasses; // Daftar kelas yang sudah dibooking
  late List<Layanan> _filteredClasses = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();

    // Inisialisasi daftar kelas yang sudah dipesan dari API
    _allClasses = [];

    // Ambil data booking user
    _getBookedClasses();
  }

  Future<void> _getBookedClasses() async {
    try {
      List<Layanan> bookings = await BookingClient.getUserBookings("");

      setState(() {
        _allClasses = bookings;
        _filteredClasses = _allClasses;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void _filterClasses(String query) {
    setState(() {
      // Filter kelas berdasarkan query pencarian
      _filteredClasses = _allClasses
          .where((classInfo) =>
              classInfo.className.toLowerCase().startsWith(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Booked Class",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 85, 101, 232),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _filterClasses,
                decoration: InputDecoration(
                  hintText: "Search Class",
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // List of Filtered Classes
            _filteredClasses.isEmpty
                ? const Expanded(
                    child: Center(
                      child: Text(
                        "No classes match your search...",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: _filteredClasses.length,
                      itemBuilder: (context, index) {
                        final classInfo = _filteredClasses[index];
                        return ClassCard(
                          className: classInfo
                              .className, // Akses data dari objek Layanan
                          timeStart:
                              classInfo.timeStart, // Akses waktu mulai kelas
                          timeEnd:
                              classInfo.timeEnd, // Akses waktu selesai kelas
                          imagePath: classInfo.imagePath,
                          details: classInfo
                              .toJson(), // Menyertakan objek Layanan lengkap sebagai detail
                          onReminderChanged: (newTime) {
                            setState(() {
                              // Jika reminderTime adalah atribut dalam objek Layanan
                              classInfo.reminderTime = newTime;
                            });
                          },
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class ClassCard extends StatelessWidget {
  final String className;
  final String timeStart;
  final String timeEnd;
  final String imagePath;
  final Map<String, dynamic> details;
  final Function(String) onReminderChanged;

  const ClassCard({
    Key? key,
    required this.className,
    required this.timeStart,
    required this.timeEnd,
    required this.imagePath,
    required this.details,
    required this.onReminderChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to ChangeReminder screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeReminder(
              reminderTime: details['reminderTime'],
              timeStart: timeStart,
              onReminderChanged: (newTime) {
                // Callback to update the reminder time
                onReminderChanged(newTime);

                // Optionally, show a confirmation message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Reminder updated to $newTime"),
                    backgroundColor: Colors.green,
                  ),
                );
              },
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Stack(
          children: [
            // Background Image
            Container(
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Gradient Overlay
            Container(
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            // Class Info
            Positioned(
              left: 16,
              bottom: 40,
              child: Text(
                className,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              right: 10,
              bottom: 45,
              child: Text(
                "$timeStart - $timeEnd WIB",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Reminder and Change Button
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 85, 101, 232),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        children: [
                          const Icon(Icons.lock_clock, color: Colors.white),
                          const SizedBox(width: 8),
                          Text(
                            "Reminder: ${details['reminderTime']}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to ChangeReminder screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangeReminder(
                              reminderTime: details['reminderTime'] ?? "08:00",
                              timeStart: timeStart,
                              onReminderChanged: (newTime) {
                                // Update the reminder time in the dataset
                                onReminderChanged(newTime);

                                // Show confirmation message
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text("Reminder updated to $newTime"),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: const [
                          Text(
                            "Change reminder time",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward, color: Colors.white),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
