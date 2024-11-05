import 'package:flutter/material.dart';
import 'package:mobile_development/converterPages/massconverter.dart';
import 'menuconverter.dart';

class TimeConverterApp extends StatelessWidget {
  const TimeConverterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Конвертер времени'),
          backgroundColor: Colors.blue.shade900,
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade900,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenuConverter()),
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
        body: MassConverter(),
      ),
    );
  }
}

class TimeConverter extends StatefulWidget {
  const TimeConverter({Key? key}) : super(key: key);

  @override
  TimeConverterState createState() => TimeConverterState();
}

class TimeConverterState extends State<TimeConverter> {
  final List<String> units = ['sec', 'min', 'h', 'day', 'week', 'month'];

  double value = 0.0;
  String unit1 = 'sec'; 
  String unit2 = 'min'; 
  String result = "";

  final Map<String, int> unitMap = {
    'sec': 0,
    'min': 1,
    'h': 2,
    'day': 3,
    'week': 4,
    'month': 5,
  };

  final List<List<double>> conversionRates = [
  [1, 1 / 60, 1 / 3600, 1 / 86400, 1 / 604800, 1 / 2592000], 
  [60, 1, 1 / 60, 1 / 1440, 1 / 10080, 1 / 43200],
  [3600, 60, 1, 1 / 24, 1 / 168, 1 / 720],
  [86400, 1440, 24, 1, 1 / 7, 1 / 30],
  [604800, 10080, 168, 7, 1, 1 / 4.345],
  [2592000, 43200, 720, 30, 4.345, 1],
];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [ 
          TextField(
            decoration: const InputDecoration(labelText: 'Введите значение'),
            keyboardType: TextInputType.number,
            onChanged: (input) {
              setState(() {
                value = double.tryParse(input) ?? 0;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DropdownButton<String>(
                value: unit1,
                items: units.map((String unit) {
                  return DropdownMenuItem<String>(
                    value: unit,
                    child: Text(unit),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    unit1 = newValue!;
                  });
                },
              ),
              DropdownButton<String>(
                value: unit2,
                items: units.map((String unit) {
                  return DropdownMenuItem<String>(
                    value: unit,
                    child: Text(unit),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    unit2 = newValue!;
                  });
                },
              ),
            ],
          ),
          ElevatedButton(
            onPressed: convert,
            child: const Text('Конвертировать!'),
          ),
          const SizedBox(height: 20),
          Text(
            result,
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  void convert() {
    int fromIndex = unitMap[unit1]!;
    int toIndex = unitMap[unit2]!;
    double multiplier = conversionRates[fromIndex][toIndex];

    setState(() {
      if (value == 0) {
        result = "Введите значение";
      } else {
        result = "$value $unit1 = ${value * multiplier} $unit2";
      }
    });
  }
}
