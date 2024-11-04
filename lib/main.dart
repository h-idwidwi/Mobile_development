import 'package:flutter/material.dart';
import 'package:mobile_development/calculator.dart';
import 'package:mobile_development/calendar.dart';
import 'package:mobile_development/foodPages/favorites_model.dart';
import 'package:mobile_development/foodPages/food.dart';
import 'package:mobile_development/foodPages/foodCategories.dart';
import 'package:mobile_development/converterPages/menuconverter.dart';
import 'package:mobile_development/task_model.dart';
import 'package:hive/hive.dart';
import 'package:mobile_development/todo.dart';
import 'package:mobile_development/weather_forecast.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:supabase_flutter/supabase_flutter.dart';

//Client ID: 5ff9dd2bab944b2cba9195c04736b0e2 Client Secret: f253c6bc2b9f44b98df371e986191c07

//Client ID: 5ff9dd2bab944b2cba9195c04736b0e2 Client Secret: f253c6bc2b9f44b98df371e986191c07

Future<void> main() async {
  try {
  WidgetsFlutterBinding.ensureInitialized();
  final applicatonDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(applicatonDocumentDir.path);
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('TODOs');
  Hive.registerAdapter(FavoritesAdapter());
  await Hive.openBox<Favorites>('foodFavorites');
  await Supabase.initialize(
    url: 'https://ekxkgfstamtsqevslkwr.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVreGtnZnN0YW10c3FldnNsa3dyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzA0NDM0NzcsImV4cCI6MjA0NjAxOTQ3N30.ebneePV0U2etjemaUVJCQCS55xHQrL9fAojT351WbWE',
  );
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade900),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => foodCategories()),
                );
              },
              child: const Text(
                  'Справочник еды',
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