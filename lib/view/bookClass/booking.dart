import 'package:flutter/material.dart';
import 'package:tubes_pbp_6/view/bookClass/selectedBookClass.dart';
import 'package:tubes_pbp_6/data/classData.dart';

class BookClass extends StatefulWidget {
  const BookClass({super.key});

  @override
  State<BookClass> createState() => _BookClassState();
}

class _BookClassState extends State<BookClass> {
  String selectedDate = "14";

  void _onDateSelected(String date) {
    setState(() {
      selectedDate = date;
    });
  }

  void _onBookClass(String className) {
    setState(() {
      final classes = classSchedules[selectedDate];
      if (classes != null) {
        final classToBook =
            classes.firstWhere((c) => c['className'] == className);
        classToBook['state'] = 'ordered';
      }
    });
  }

  void _onCancelClass(String className) {
    setState(() {
      final classes = classSchedules[selectedDate];
      if (classes != null) {
        final classToCancel =
            classes.firstWhere((c) => c['className'] == className);
        classToCancel['state'] = 'available';
      }
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
            child: ClassList(
              classes: classSchedules[selectedDate] ?? [],
              onBook: _onBookClass,
              onCancel: _onCancelClass,
            ),
          ),
        ],
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
          color: Color.fromARGB(255, 85, 101, 232),
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
                decoration: BoxDecoration(
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
                      // Custom logo on the left
                      Image.asset(
                        'lib/assets/preLoginAsset/Logo.jpg', // Replace with your logo asset path
                        width: 40,
                        height: 40,
                      ),
                      // "OCTOBER" text in the center
                      Text(
                        'OCTOBER',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Notification icon on the right
                      Transform.scale(
                        scale: 2,
                        child: IconButton(
                          icon: Icon(
                            Icons.notifications,
                            color: Colors.black,
                          ),
                          onPressed: () {},
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
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 60,
      color: Color.fromARGB(255, 85, 101, 232),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          DateCircle(
            day: "Sun",
            date: "13",
            isSelected: selectedDate == "13",
            onPressed: onDateSelected,
          ),
          DateCircle(
            day: "Mon",
            date: "14",
            isSelected: selectedDate == "14",
            onPressed: onDateSelected,
          ),
          DateCircle(
            day: "Tue",
            date: "15",
            isSelected: selectedDate == "15",
            onPressed: onDateSelected,
          ),
          DateCircle(
            day: "Wen",
            date: "16",
            isSelected: selectedDate == "16",
            onPressed: onDateSelected,
          ),
          DateCircle(
            day: "Thu",
            date: "17",
            isSelected: selectedDate == "17",
            onPressed: onDateSelected,
          ),
        ],
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
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                date,
                style: TextStyle(
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
  final List<Map<String, dynamic>> classes;
  final Function(String) onBook;
  final Function(String) onCancel;

  const ClassList({
    Key? key,
    required this.classes,
    required this.onBook,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (classes.isEmpty) {
      return Center(
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
          final classInfo = classes[index];
          return ClassCard(
            className: classInfo["className"]!,
            timeStart: classInfo["timeStart"]!,
            timeEnd: classInfo["timeEnd"]!,
            imagePath: classInfo["className"],
            details: classInfo,
            onBook: onBook,
            onCancel: onCancel,
          );
        },
      );
    }
  }
}

class ClassCard extends StatelessWidget {
  final String className;
  final String timeStart;
  final String timeEnd;
  final String imagePath;
  final Map<String, dynamic> details;
  final Function(String) onBook;
  final Function(String) onCancel;

  const ClassCard({
    Key? key,
    required this.className,
    required this.timeStart,
    required this.timeEnd,
    required this.imagePath,
    required this.details,
    required this.onBook,
    required this.onCancel,
  }) : super(key: key);

  String _getImagePath(String className) {
    final imageMap = {
      'Zumba': 'images/zumba.jpg',
      'Aerobic': 'images/aerobic.jpg',
      'Boxing': 'images/boxing.jpg',
      'Pilates': 'images/pilates.jpg',
      'Lifting': 'images/lifting.jpg',
      'Dance': 'images/dance.jpg',
      'Yoga': 'images/yoga.jpg',
    };
    return imageMap[className] ?? 'images/download.jpg';
  }

  Color _getContainerColor(String state) {
    switch (state) {
      case 'ordered':
        return Colors.yellow;
      case 'booked':
        return Colors.green;
      default:
        return Color.fromARGB(255, 85, 101, 232);
    }
  }

  String _getContainerText(String state) {
    switch (state) {
      case 'ordered':
        return 'O\nR\nD\nE\nR\nE\nD';
      case 'booked':
        return 'B\nO\nO\nK\nE\nD';
      default:
        return 'O\nR\nD\nE\nR';
    }
  }

  TextStyle _getContainerTextStyle(String state) {
    switch (state) {
      case 'ordered':
        return TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 10,
        );
      default:
        return TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final String state = details['state'] ?? 'available';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SelectedClassBook(
              className: className,
              timeStart: timeStart,
              timeEnd: timeEnd,
              imagePath: _getImagePath(className),
              details: details,
              onBook: onBook,
              onCancel: onCancel,
            ),
          ),
        );
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
                  image: AssetImage(_getImagePath(className)),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            Positioned(
              left: 16,
              bottom: 16,
              child: Text(
                className,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              right: 65,
              bottom: 16,
              child: Text(
                "$timeStart - $timeEnd",
                style: TextStyle(
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
                  color: _getContainerColor(state),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _getContainerText(state),
                        textAlign: TextAlign.center,
                        style: _getContainerTextStyle(state),
                      ),
                      SizedBox(height: 8),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 25,
                      ),
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
