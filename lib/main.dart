import 'package:flutter/material.dart';
import 'package:mobile_development/calculator.dart';
import 'package:mobile_development/menuconverter.dart';

void main() {
  runApp(MenuApp());
}

class MenuApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Menu(),
    );
  }
}

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Меню'),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade900),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalculatorApp()),
                );
              },
              child: const Text(
                  'Калькулятор',
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
                  MaterialPageRoute(builder: (context) => MenuConverterApp()),
                );
              },
              child: const Text(
                  'Конвертер',
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