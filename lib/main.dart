import 'package:flutter/material.dart';
import 'package:mobile_development/calculator.dart';
import 'package:mobile_development/calendar.dart';
import 'package:mobile_development/menuconverter.dart';
import 'package:mobile_development/task_model.dart';
import 'package:hive/hive.dart';
import 'package:mobile_development/todo.dart';
import 'package:mobile_development/weather_forecast.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

//Client ID: 5ff9dd2bab944b2cba9195c04736b0e2 Client Secret: f253c6bc2b9f44b98df371e986191c07

Future<void> main() async {
  try {
  WidgetsFlutterBinding.ensureInitialized();
  final applicatonDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(applicatonDocumentDir.path);
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('TODOs');
  runApp(MenuApp());
  }
  catch(e) {
    print(e);
  }
}

class MenuApp extends StatelessWidget{
  const MenuApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Menu(),
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

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
                  MaterialPageRoute(builder: (context) => Calculator()),
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
                  MaterialPageRoute(builder: (context) => MenuConverter()),
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade900),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Calendar()),
                );
              },
              child: const Text(
                  'Календарь',
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
                  MaterialPageRoute(builder: (context) => TODO()),
                );
              },
              child: const Text(
                  'TODO',
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
                  MaterialPageRoute(builder: (context) => WeatherForecast()),
                );
              },
              child: const Text(
                  'Прогноз погоды',
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