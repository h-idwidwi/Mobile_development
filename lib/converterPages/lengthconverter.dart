import 'package:flutter/material.dart';
import 'menuconverter.dart';

class LengthConverterApp extends StatelessWidget {
  const LengthConverterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Конвертер длины'),
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
        body: LengthConverter(),
      ),
    );
  }
}

class LengthConverter extends StatefulWidget {
  const LengthConverter({Key? key}) : super(key: key);

  @override
  LengthConverterState createState() => LengthConverterState();
}

class LengthConverterState extends State<LengthConverter> {
  final List<String> units = ['cm', 'm', 'km', 'dm', 'ft'];

  double value = 0.0;
  String unit1 = 'cm'; 
  String unit2 = 'm'; 
  String result = "";

  final Map<String, int> unitMap = {
    'cm': 0,
    'm': 1,
    'km': 2,
    'dm': 3,
    'ft': 4,
  };

  final List<List<double>> conversionRates = [
    [1, 0.01, 0.00001, 0.1, 0,032808],
    [100, 1, 1000, 10, 3.28],
    [0.00001, 0.001, 1, 10000, 3280.84],
    [10, 0.1, 0.0001, 1, 0,328084],
    [30, 0.03, 0.0003, 0.3, 1],
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
