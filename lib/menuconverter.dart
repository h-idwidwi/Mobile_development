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
      home: MenuConverter(),
    );
  }
}

class MenuConverter extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Меню конвертера'),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.all(40),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade900,
                    ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Menu()),
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
            ),
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