import 'package:flutter/material.dart';
import 'menuconverter.dart';

class MassConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Конвертер массы'),
        ),
        body: MassConverter(),
      ),
    );
  }
}

class MassConverter extends StatefulWidget {
  @override
  MassConverterState createState() => MassConverterState();
}

class MassConverterState extends State<MassConverter> {
  final List<String> units = ['gr', 'kg', 'mg'];

  double value = 0.0;
  String unit1 = 'gr'; 
  String unit2 = 'kg'; 
  String result = "";

  final Map<String, int> unitMap = {
    'gr': 0,
    'kg': 1,
    'mg': 2,
  };

  final List<List<double>> conversionRates = [
    [1, 0.001, 1000],
    [1000, 1, 1000000],
    [0.001, 0.000001, 1],
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade900,
                ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenuConverterApp()),
                );
              },
              child: const Text(
                  'Меню',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
          ),  
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
