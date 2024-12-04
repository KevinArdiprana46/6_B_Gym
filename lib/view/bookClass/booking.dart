import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'package:tubes_pbp_6/view/bookClass/selectedBookClass.dart';
import 'package:tubes_pbp_6/view/bookClass/notificationBooking.dart';
import 'package:tubes_pbp_6/data/classData.dart';
import 'package:tubes_pbp_6/view/home.dart';
import 'package:tubes_pbp_6/view/Profile/profile.dart';
import 'package:tubes_pbp_6/client/layananClient.dart';
import 'package:tubes_pbp_6/client/bookingClient.dart';
import 'package:tubes_pbp_6/entity/layanan.dart';
import 'package:tubes_pbp_6/entity/booking.dart';

class BookClass extends StatefulWidget {
  const BookClass({super.key});

  @override
  State<BookClass> createState() => _BookClassState();
}

class _BookClassState extends State<BookClass> with TickerProviderStateMixin {
  String selectedDate = "";
  MotionTabBarController? _motionTabBarController;
  late Future<List<Layanan>> _layananFuture;

  @override
  void initState() {
    super.initState();
    _motionTabBarController = MotionTabBarController(
      initialIndex: 2,
      length: 5,
      vsync: this,
    );
    _layananFuture = LayananClient.getLayananWithBookingStatus(
        '04'); // Fetch layanan based on selected date
  }

  @override
  void dispose() {
    _motionTabBarController?.dispose();
    super.dispose();
  }

  void _onDateSelected(String date) {
    setState(() {
      selectedDate =
          date; // Menyimpan tanggal sebagai string dengan format "dd"
      _layananFuture = LayananClient.getLayananWithBookingStatus(
          selectedDate); // Gunakan format 'yyyy-MM-dd' pada API call
    });
  }

  void _onItemTapped(int index) {
    if (index != _motionTabBarController!.index) {
      switch (index) {
        case 0:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BerandaView()),
          );
          break;
        case 2:
          // Booking tab, can be left empty if we handle the booking UI within this tab
          break;
        case 4:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MyWidget()),
          );
          break;
        default:
          break;
      }
    }
  }

  // Method to handle booking
  void _onBookClass(int layananId) async {
    try {
      await BookingClient.bookClass(layananId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Class successfully booked")),
      );
      // Trigger a refresh to update the booking state
      setState(() {
        _layananFuture =
            LayananClient.getLayananWithBookingStatus(selectedDate);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Booking failed: $e")),
      );
    }
  }

  // Method to handle class cancellation
  void _onCancelClass(int layananId) async {
    try {
      await BookingClient.cancelBooking(layananId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Booking successfully cancelled")),
      );
      // Trigger a refresh to update the booking state
      setState(() {
        _layananFuture =
            LayananClient.getLayananWithBookingStatus(selectedDate);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Cancellation failed: $e")),
      );
    }
  }

  void _updateBookingStatus() {
    setState(() {
      _layananFuture = LayananClient.getLayananWithBookingStatus(selectedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          CustomHeader(
            selectedDate: selectedDate,
            onDateSelected: _onDateSelected,
          ),
          Expanded(
            child: FutureBuilder<List<Layanan>>(
              future:
                  _layananFuture, // Use the future to load data based on selected date
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text("No classes available for this date"));
                } else {
                  final services = snapshot.data!;
                  return ListView.builder(
                    itemCount: services.length,
                    itemBuilder: (context, index) {
                      final layanan = services[index];
                      return ClassCard(
                        layanan: layanan,
                        selectedDate: selectedDate,
                        onBook: (className) => _onBookClass(layanan.id),
                        onCancel: (className) => _onCancelClass(layanan.id),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: MotionTabBar(
        controller: _motionTabBarController,
        initialSelectedTab: "Booking",
        labels: const ["Home", "Review", "Booking", "Payment", "Profile"],
        icons: const [
          Icons.home,
          Icons.reviews,
          Icons.calendar_month_outlined,
          Icons.shopping_cart,
          Icons.people_alt,
        ],
        tabSize: 50,
        tabBarHeight: 55,
        textStyle: const TextStyle(
          fontSize: 12,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        tabIconColor: Colors.blue[600],
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: Colors.blue[900],
        tabIconSelectedColor: Colors.white,
        tabBarColor: Colors.white,
        onTabItemSelected: _onItemTapped,
      ),
    );
  }
}

class CustomHeader extends StatelessWidget {
  final String selectedDate;
  final Function(String) onDateSelected;

  const CustomHeader({
    Key? key,
    required this.selectedDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.33,
          color: const Color.fromARGB(255, 85, 101, 232),
        ),
        Positioned(
          top: 120,
          left: 0,
          right: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width - 70,
                height: MediaQuery.of(context).size.height * 0.12,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Transform.scale(
                        scale: 2,
                        child: Image.asset(
                          'lib/assets/Logo2.png',
                          width: 40,
                          height: 40,
                        ),
                      ),
                      const Text(
                        'OCTOBER',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Transform.scale(
                        scale: 2,
                        child: IconButton(
                          icon: const Icon(
                            Icons.notifications,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            final bookedClasses = classSchedules.values
                                .expand((classes) => classes)
                                .where((classInfo) =>
                                    classInfo['state'] == 'booked')
                                .toList();

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NotificationBooking(
                                  bookedClasses: bookedClasses,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              CalendarStrip(
                selectedDate: selectedDate,
                onDateSelected: onDateSelected,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CalendarStrip extends StatelessWidget {
  final String selectedDate;
  final Function(String) onDateSelected;

  const CalendarStrip({
    Key? key,
    required this.selectedDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    List<DateTime> dates =
        List.generate(5, (index) => now.add(Duration(days: index)));

    // Fungsi untuk mendapatkan nama hari berdasarkan DateTime.weekday
    String getDayName(int weekday) {
      switch (weekday) {
        case DateTime.monday:
          return "Mon";
        case DateTime.tuesday:
          return "Tue";
        case DateTime.wednesday:
          return "Wed";
        case DateTime.thursday:
          return "Thu";
        case DateTime.friday:
          return "Fri";
        case DateTime.saturday:
          return "Sat";
        case DateTime.sunday:
          return "Sun";
        default:
          return "";
      }
    }

    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 60,
      color: const Color.fromARGB(255, 85, 101, 232),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: dates.map((date) {
          String day = getDayName(date.weekday);
          String dateString = date.day.toString().padLeft(
              2, '0'); // Menambahkan padding agar dua digit (misal 01, 02)

          return DateCircle(
            day: day,
            date: dateString,
            isSelected:
                selectedDate == dateString, // Cek apakah tanggal ini dipilih
            onPressed: onDateSelected,
          );
        }).toList(),
      ),
    );
  }
}

class DateCircle extends StatelessWidget {
  final String day;
  final String date;
  final bool isSelected;
  final Function(String) onPressed;

  const DateCircle({
    Key? key,
    required this.day,
    required this.date,
    this.isSelected = false,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(date),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: 60,
          height: 50,
          decoration: BoxDecoration(
            color: isSelected ? Colors.red : Colors.transparent,
            border: Border.all(
              color: isSelected ? Colors.red : Colors.white,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                day,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                date,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ClassList extends StatelessWidget {
  final List<Layanan> classes;
  final Function(String) onBook;
  final Function(String) onCancel;
  final String selectedDate;

  const ClassList({
    Key? key,
    required this.classes,
    required this.onBook,
    required this.onCancel,
    required this.selectedDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (classes.isEmpty) {
      return const Center(
        child: Text(
          "There is no class available \nfor this day...",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: classes.length,
        itemBuilder: (context, index) {
          final classInfo = classes[index]; // Layanan object
          return ClassCard(
            layanan: classInfo, // Mengirim objek Layanan langsung
            onBook: onBook,
            onCancel: onCancel,
            selectedDate: selectedDate,
          );
        },
      );
    }
  }
}

class ClassCard extends StatelessWidget {
  final Layanan layanan;
  final Function(String) onBook;
  final Function(String) onCancel;
  final String selectedDate;

  const ClassCard({
    Key? key,
    required this.layanan,
    required this.onBook,
    required this.onCancel,
    required this.selectedDate,
  }) : super(key: key);

  bool _isConflict(String currentStart, String currentEnd) {
    final currentClasses = classSchedules[selectedDate] ?? [];

    return currentClasses.any((classItem) {
      if (classItem['className'] == layanan.className ||
          classItem['state'] != 'ordered' && classItem['state'] != 'booked') {
        return false;
      }
      final startTime = _parseTime(currentStart);
      final endTime = _parseTime(currentEnd);
      final otherStartTime = _parseTime(classItem['timeStart']);
      final otherEndTime = _parseTime(classItem['timeEnd']);

      return (startTime.isBefore(otherEndTime) &&
          endTime.isAfter(otherStartTime));
    });
  }

  DateTime _parseTime(String time) {
    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return DateTime(0, 1, 1, hour, minute);
  }

  Color _getContainerColor(String state, bool conflict, int availableSlots) {
    if (availableSlots == 0 || conflict) return Colors.grey;
    switch (state) {
      case 'ordered':
        return Colors.green;
      case 'booked':
        return Colors.red;
      case 'available':
        return const Color.fromARGB(255, 85, 101, 232);
      default:
        return const Color.fromARGB(255, 85, 101, 232);
    }
  }

  String _getContainerText(String state, bool conflict, int availableSlots) {
    if (availableSlots == 0 || conflict) return 'Not\nAvailable';
    switch (state) {
      case 'ordered':
        return 'O\nR\nD\nE\nR\nE\nD';
      case 'booked':
        return 'B\nO\nO\nK\nE\nD';
      case 'available':
        return 'O\nR\nD\nE\nR';
      default:
        return 'O\nR\nD\nE\nR';
    }
  }

  TextStyle _getContainerTextStyle(
      String state, bool conflict, int availableSlots) {
    if (availableSlots == 0 || conflict) {
      return const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 10,
      );
    }
    switch (state) {
      case 'ordered':
        return const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 10,
        );
      case 'booked':
        return const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        );
      case 'available':
        return const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        );
      default:
        return const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final String state = layanan.state; // Menggunakan atribut dari Layanan
    final int availableSlots =
        layanan.availableSlots; // Menggunakan atribut dari Layanan
    final bool conflict = _isConflict(
        layanan.timeStart, layanan.timeEnd); // Menggunakan data dari layanan
    return GestureDetector(
      onTap: () {
        if (availableSlots > 0 && !conflict) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SelectedClassBook(
                className: layanan.className, // Menggunakan data dari layanan
                timeStart: layanan.timeStart,
                timeEnd: layanan.timeEnd,
                imagePath: layanan.imagePath,
                details: layanan.toJson(),
                onBook: onBook,
                onCancel: onCancel,
              ),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Stack(
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                image: DecorationImage(
                  image: AssetImage(
                      layanan.imagePath), // Menggunakan data dari layanan
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                gradient: const LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black,
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            Positioned(
              left: 16,
              bottom: 16,
              child: Text(
                layanan.className, // Menggunakan data dari layanan
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              right: 65,
              bottom:
                  40, // Adjust as needed to place it above timeStart-timeEnd
              child: Text(
                '$availableSlots slot left', // Menggunakan data dari layanan
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18, // Adjust font size as needed
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              right: 65,
              bottom: 16,
              child: Text(
                "${layanan.timeStart} - ${layanan.timeEnd} WIB", // Menggunakan data dari layanan
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 60,
                decoration: BoxDecoration(
                  color: _getContainerColor(state, conflict, availableSlots),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _getContainerText(state, conflict, availableSlots),
                        textAlign: TextAlign.center,
                        style: _getContainerTextStyle(
                            state, conflict, availableSlots),
                      ),
                      if (availableSlots > 0 && !conflict) ...[
                        const SizedBox(height: 8),
                        const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 25,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
