import 'package:flutter/material.dart';
import 'package:mobile_development/finance.dart';
import 'package:mobile_development/calculator.dart';
import 'package:mobile_development/calendar.dart';
import 'package:mobile_development/foodPages/favorites_model.dart';
import 'package:mobile_development/foodPages/foodCategories.dart';
import 'package:mobile_development/converterPages/menuconverter.dart';
import 'package:mobile_development/newsPages/newsMain.dart';
import 'package:mobile_development/newsPages/news_model.dart';
import 'package:mobile_development/task_model.dart';
import 'package:hive/hive.dart';
import 'package:mobile_development/todo.dart';
import 'package:mobile_development/weather_forecast.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  try {
  WidgetsFlutterBinding.ensureInitialized();
  final applicatonDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(applicatonDocumentDir.path);
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('TODOs');
  Hive.registerAdapter(FavoritesAdapter());
  await Hive.openBox<Favorites>('foodFavorites');
  Hive.registerAdapter(NewsAdapter());
  await Hive.openBox<News>('news');
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
        title: Text('Меню', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.calculate,
                    color: Colors.blue.shade900,
                    size: 100,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Calculator()),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.change_circle,
                    color: Colors.blue.shade900,
                    size: 100,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MenuConverter()),
                    );
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.calendar_month,
                    color: Colors.blue.shade900,
                    size: 100,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Calendar()),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.task,
                    color: Colors.blue.shade900,
                    size: 100,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TODO()),
                    );
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.cloud,
                    color: Colors.blue.shade900,
                    size: 100,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WeatherForecast()),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.food_bank,
                    color: Colors.blue.shade900,
                    size: 100,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => foodCategories()),
                    );
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.newspaper,
                    color: Colors.blue.shade900,
                    size: 100,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewsMain()),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.money_sharp,
                    color: Colors.blue.shade900,
                    size: 100,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Finance()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
