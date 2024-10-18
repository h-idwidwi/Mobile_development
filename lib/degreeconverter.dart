import 'package:flutter/material.dart';
import 'menuconverter.dart';

class DegreeConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Конвертер температуры'),
        ),
        body: DegreeConverter(),
      ),
    );
  }
}

class DegreeConverter extends StatefulWidget {
  @override
  DegreeConverterState createState() => DegreeConverterState();
}

class DegreeConverterState extends State<DegreeConverter> {
  final List<String> units = ['C', 'F', 'K'];

  double value = 0.0;
  String unit1 = 'C'; 
  String unit2 = 'F'; 
  String result = "";

  final Map<String, int> unitMap = {
    'C': 0,
    'F': 1,
    'K': 2,
  };

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
    
    double convertedValue = 0.0;
    if (unit1 == 'C' && unit2 == 'F') {
      convertedValue = value * 9 / 5 + 32;
    } else if (unit1 == 'C' && unit2 == 'K') {
      convertedValue = value + 273.15;
    } else if (unit1 == 'F' && unit2 == 'C') {
      convertedValue = (value - 32) * 5 / 9;
    } else if (unit1 == 'F' && unit2 == 'K') {
      convertedValue = (value - 32) * 5 / 9 + 273.15;
    } else if (unit1 == 'K' && unit2 == 'C') {
      convertedValue = value - 273.15;
    } else if (unit1 == 'K' && unit2 == 'F') {
      convertedValue = (value - 273.15) * 9 / 5 + 32;
    } else {
      convertedValue = value;
    }

    setState(() {
      result = "$value $unit1 = $convertedValue $unit2";
    });
  }
}
