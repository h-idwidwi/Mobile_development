import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_development/main.dart';

class CalendarApp extends StatelessWidget {
  const CalendarApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Calendar(),
    );
  }
}

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  CalendarState createState() => CalendarState();
}

class CalendarState extends State<Calendar> {
  DateTime currentDate = DateTime.now();
  late DateTime selectedDate;

  List<String> ruMonths = [
    'Январь',
    'Февраль',
    'Март',
    'Апрель',
    'Май',
    'Июнь',
    'Июль',
    'Август',
    'Сентябрь',
    'Октябрь',
    'Ноябрь',
    'Декабрь',
  ];

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime(currentDate.year, currentDate.month);
  }

  void goToToday() {
    setState(() {
      selectedDate = DateTime(currentDate.year, currentDate.month);
    });
  }

  void changeMonth(int change) {
    setState(() {
      selectedDate = DateTime(selectedDate.year, selectedDate.month + change);
    });
  }

  void changeYear(int change) {
    setState(() {
      selectedDate = DateTime(selectedDate.year + change, selectedDate.month);
    });
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = DateTime(selectedDate.year, selectedDate.month + 1, 0).day;
    final firstWeekday = DateTime(selectedDate.year, selectedDate.month, 1).weekday;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Календарь"),
        backgroundColor: Colors.blue.shade900,
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade900,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenuApp()),
                );
              },
              child: const Text(
                'Меню',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                ),
                onPressed: () => changeYear(-1),
              ),
              IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_left,
                ),
                onPressed: () => changeMonth(-1),
              ),
              Text(
                "${ruMonths[selectedDate.month - 1]} ${DateFormat.y().format(selectedDate)}",
                style: TextStyle(
                  fontSize: 24, 
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_right,
                ),
                onPressed: () => changeMonth(1),
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                ),
                onPressed: () => changeYear(1),
              ),
            ],
          ),
          
          if (selectedDate.month != currentDate.month || selectedDate.year != currentDate.year)
            ElevatedButton(
              onPressed: goToToday,
              child: Text(
                "Вернуться к текущей дате",
              ),
            ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: 
              [
                "Пн", 
                "Вт", 
                "Ср", 
                "Чт", 
                "Пт", 
                "Сб", 
                "Вс"
              ].map((day) => Text(
                day, 
                style: TextStyle(
                  fontWeight: FontWeight.bold),
              )).toList(),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
              itemCount: daysInMonth + firstWeekday - 1,
              itemBuilder: (context, index) {
                if (index < firstWeekday - 1) {
                  return Container();
                }
                final day = index - firstWeekday + 2;
                final isToday = day == currentDate.day && selectedDate.month == currentDate.month && selectedDate.year == currentDate.year;
                return GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      color: isToday ? Colors.blue.shade100 : null,
                      border: Border.all(color: Colors.blue.shade300),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      day.toString(),
                      style: TextStyle(
                        fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                        color: isToday ? Colors.blue : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}