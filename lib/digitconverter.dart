import 'package:flutter/material.dart';
import 'menuconverter.dart';

class DigitConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Конвертер систем счисления'),
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
        body: DigitConverter(),
      ),
    );
  }
}

class DigitConverter extends StatefulWidget {
  @override
  DigitConverterState createState() => DigitConverterState();
}

class DigitConverterState extends State<DigitConverter> {
  final List<String> units = ['decimal', 'binary', 'hexadecimal'];

  String input = "";
  String unit1 = 'decimal';
  String unit2 = 'binary';
  String result = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Введите значение'),
            keyboardType: TextInputType.number,
            onChanged: (inputValue) {
              setState(() {
                input = inputValue;
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
    try {
      int decimalValue;
      if (unit1 == 'decimal') {
        decimalValue = int.parse(input);
      } else if (unit1 == 'binary') {
        decimalValue = int.parse(input, radix: 2);
      } else if (unit1 == 'hexadecimal') {
        decimalValue = int.parse(input, radix: 16);
      } else {
        return;
      }

      if (unit2 == 'decimal') {
        result = "$input $unit1 = $decimalValue $unit2";
      } else if (unit2 == 'binary') {
        result = "$input $unit1 = ${decimalValue.toRadixString(2)} $unit2";
      } else if (unit2 == 'hexadecimal') {
        result = "$input $unit1 = ${decimalValue.toRadixString(16).toUpperCase()} $unit2";
      } else {
      }
    } catch (e) {
      setState(() {
      });
    }

    setState(() {});
  }
}
