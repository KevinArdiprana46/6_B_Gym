import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangeReminder extends StatefulWidget {
  final String reminderTime;
  final String timeStart;
  final Function(String) onReminderChanged;

  const ChangeReminder({
    Key? key,
    required this.reminderTime,
    required this.timeStart,
    required this.onReminderChanged,
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
    final timeParts = widget.reminderTime.split(":");
    _selectedHour = int.parse(timeParts[0]);
    _selectedMinute = int.parse(timeParts[1]);
  }

  void _saveReminder() {
    // Format selected time as HH:mm
    final formattedTime =
        "${_selectedHour.toString().padLeft(2, '0')}:${_selectedMinute.toString().padLeft(2, '0')}";

    // Check if reminder is at least 1 hour before the start time
    final selectedDateTime = DateTime(0, 1, 1, _selectedHour, _selectedMinute);
    final timeStartParts = widget.timeStart.split(":");
    final timeStartDateTime = DateTime(
      0,
      1,
      1,
      int.parse(timeStartParts[0]),
      int.parse(timeStartParts[1]),
    );

    final durationBeforeStart = timeStartDateTime.difference(selectedDateTime);
    if (durationBeforeStart.inMinutes >= 60) {
      // Update the dataset reminderTime via the callback
      widget.onReminderChanged(formattedTime);

      // Close the screen
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text("Reminder must be at least 1 hour before the start time."),
          backgroundColor: Colors.red,
        ),
      );
    }
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
