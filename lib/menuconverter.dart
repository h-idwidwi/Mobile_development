import 'package:flutter/material.dart';
import 'package:mobile_development/degreeconverter.dart';
import 'package:mobile_development/digitconverter.dart';
import 'package:mobile_development/timeconverter.dart';
import 'massconverter.dart';
import 'lengthconverter.dart';
import 'main.dart';

class MenuConverterApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
        body: Menu(),
      ),
    );
  }
}

class MenuConverter extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Конвертер'),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade900),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MassConverterApp()),
                );
              },
              child: const Text(
                  'Масса',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade900),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LengthConverterApp()),
                );
              },
              child: const Text(
                  'Длина',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade900),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DegreeConverterApp()),
                );
              },
              child: const Text(
                  'Температура',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade900),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TimeConverterApp()),
                );
              },
              child: const Text(
                  'Время',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade900),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DigitConverterApp()),
                );
              },
              child: const Text(
                  'Системы счисления',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}