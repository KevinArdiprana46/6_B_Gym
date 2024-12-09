import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tubes_pbp_6/client/bookingClient.dart';
import 'package:tubes_pbp_6/view/bookClass/notificationBooking.dart';

class ChangeReminder extends StatefulWidget {
  final String reminderTime;
  final String timeStart;
  final Function(String) onReminderChanged;
  final int layananId;

  const ChangeReminder({
    Key? key,
    required this.reminderTime,
    required this.timeStart,
    required this.onReminderChanged,
    required this.layananId,
  }) : super(key: key);

  @override
  _ChangeReminderState createState() => _ChangeReminderState();
}

class _ChangeReminderState extends State<ChangeReminder> {
  late int _selectedHour;
  late int _selectedMinute;

  @override
  void initState() {
    super.initState();
    // Parse the existing reminder time from the dataset
    DateTime reminderDateTime = DateTime.parse(widget.reminderTime);

    // Extract hours and minutes from the DateTime object
    _selectedHour = reminderDateTime.hour;
    _selectedMinute = reminderDateTime.minute;
  }

  void _saveReminder() {
    //final bookingId = BookingClient.getBookingId(classInfo.layananId);
    DateTime oldReminderDateTime = DateTime.parse(widget.reminderTime);
    DateTime newReminderDateTime = DateTime(
      oldReminderDateTime.year,
      oldReminderDateTime.month,
      oldReminderDateTime.day,
      _selectedHour,
      _selectedMinute,
    );

    // Ubah ke format string ISO8601
    String newReminderTime = newReminderDateTime.toIso8601String();

    // Panggil fungsi untuk mengupdate waktu pengingat di API
    BookingClient.updateReminderTime(widget.layananId, newReminderTime)
        .then((_) {
      // Tampilkan snackbar atau feedback lainnya setelah berhasil
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Reminder updated to $newReminderTime')),
      );

      // Kembali ke halaman sebelumnya
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NotificationBooking()),
      );
    }).catchError((error) {
      // Tampilkan error jika terjadi
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update reminder')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Change Reminder Time",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 85, 101, 232),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 85, 101, 232),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Set Reminder Time",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Hour Picker
                    Expanded(
                      child: CupertinoPicker(
                        itemExtent: 50,
                        scrollController: FixedExtentScrollController(
                          initialItem: _selectedHour,
                        ),
                        onSelectedItemChanged: (index) {
                          setState(() {
                            _selectedHour = index;
                          });
                        },
                        children: List<Widget>.generate(
                          24,
                          (index) => Center(
                            child: Text(
                              index.toString().padLeft(2, '0'),
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      ":",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    // Minute Picker
                    Expanded(
                      child: CupertinoPicker(
                        itemExtent: 50,
                        scrollController: FixedExtentScrollController(
                          initialItem: _selectedMinute,
                        ),
                        onSelectedItemChanged: (index) {
                          setState(() {
                            _selectedMinute = index;
                          });
                        },
                        children: List<Widget>.generate(
                          60,
                          (index) => Center(
                            child: Text(
                              index.toString().padLeft(2, '0'),
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _saveReminder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Save",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 85, 101, 232),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
