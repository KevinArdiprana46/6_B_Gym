import 'package:flutter/material.dart';

class BookClass extends StatefulWidget {
  const BookClass({super.key});

  @override
  State<BookClass> createState() => _BookClassState();
}

class _BookClassState extends State<BookClass> {
  String selectedDate = "14"; // Default selected date

  final Map<String, List<Map<String, String>>> classSchedules = {
    "13": [
      {"className": "Yoga", "time": "08.00 - 09.00 WIB"},
      {"className": "Zumba", "time": "10.00 - 11.00 WIB"},
    ],
    "14": [
      {"className": "Aerobic", "time": "17.00 - 18.00 WIB"},
      {"className": "Boxing", "time": "17.00 - 18.00 WIB"},
      {"className": "Pilates", "time": "17.00 - 19.00 WIB"},
      {"className": "Zumba", "time": "18.00 - 20.00 WIB"},
    ],
    "15": [
      {"className": "Lifting", "time": "18.00 - 20.00 WIB"},
      {"className": "Dance", "time": "19.00 - 20.00 WIB"},
    ],
    // Add more dates and classes as needed
  };

  // Update selected date and refresh displayed classes
  void _onDateSelected(String date) {
    setState(() {
      selectedDate = date;
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
              classes: classSchedules[selectedDate] ??
                  [], // Show classes for the selected date
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
          height: MediaQuery.of(context).size.height * 0.35,
          color: Color.fromARGB(255, 85, 101, 232),
        ),
        Positioned(
          top: 140,
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
                child: Center(
                  child: Text(
                    'OCTOBER',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
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
  final List<Map<String, String>> classes;

  const ClassList({Key? key, required this.classes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: classes.length,
      itemBuilder: (context, index) {
        final classInfo = classes[index];
        return ClassCard(
          className: classInfo["className"]!,
          time: classInfo["time"]!,
        );
      },
    );
  }
}

class ClassCard extends StatelessWidget {
  final String className;
  final String time;

  const ClassCard({Key? key, required this.className, required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Stack(
        children: [
          // gambar kelas
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              image: DecorationImage(
                image: AssetImage('images/download.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // gradien gambar
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
          // className
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
          // time
          Positioned(
            right: 65,
            bottom: 16,
            child: Text(
              time,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // book
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 60,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 85, 101, 232),
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
                      'B\nO\nO\nK',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
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
    );
  }
}
