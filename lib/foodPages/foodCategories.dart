import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_development/foodPages/favorites_model.dart';
import 'package:mobile_development/foodPages/food.dart';
import 'package:mobile_development/foodPages/foodByCategories.dart';
import 'package:mobile_development/foodPages/foodBySearch.dart';
import 'package:mobile_development/foodPages/foodFavorites.dart';

class foodCategoriesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: foodCategories(),
      ),
    );
  }
}

class foodCategories extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => foodCategoriesState();
}

class foodCategoriesState extends State<foodCategories> {
  late Box<Favorites> favoritesBox;
  String input = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Категории продуктов'),
        backgroundColor: Colors.blue.shade900,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              icon: Icon(Icons.favorite_border_sharp),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => foodFavorites()),
                );
              },
          )
        ],
      ),
      body: Column(
            children: [
              SizedBox(
                width: 350,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Введите название еды",
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    input = value;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (input.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FoodBySearch(input),
                      ),
                    );
                  }
                },
                child: Text(
                  "Найти еду", 
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    child: Text(
                      '🗂',
                      style: TextStyle(
                        fontSize: 70,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => Food(),
                        )
                      );
                    }
                  ),
                  TextButton(
                    child: Text(
                      '🥤',
                      style: TextStyle(
                        fontSize: 70,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => FoodByCategories('1'),
                        )
                      );
                    }
                  ),
                ]
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    child: Text(
                      '🥦',
                      style: TextStyle(
                        fontSize: 70,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => FoodByCategories('4'),
                        )
                      );
                    }
                  ),
                  TextButton(
                    child: Text(
                      '🐄',
                      style: TextStyle(
                        fontSize: 70,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => FoodByCategories('5'),
                        )
                      );
                    }
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    child: Text(
                      '🍄',
                      style: TextStyle(
                        fontSize: 70,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => FoodByCategories('6'),
                        )
                      );
                    }
                  ),
                  TextButton(
                    child: Text(
                      '🍻',
                      style: TextStyle(
                        fontSize: 70,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => FoodByCategories('7'),
                        )
                      );
                    }
                  ),
                ],
              ),
            ],
          ),
      );
  }
  @override
  void initState() {
    super.initState();
    favoritesBox = Hive.box<Favorites>('foodFavorites');
  }
}