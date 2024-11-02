import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FoodApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Food(),
      ),
    );
  }
}

class Food extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FoodState();
}

class FoodState extends State<Food> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Справочник продуктов'),
        backgroundColor: Colors.blue.shade900,
        automaticallyImplyLeading: false,
      ),
    );
  }
}