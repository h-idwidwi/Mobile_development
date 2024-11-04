import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_development/foodPages/favorites_model.dart';
import 'package:mobile_development/foodPages/food.dart';
import 'package:mobile_development/foodPages/foodCategories.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class foodFavoritesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: foodFavorites(),
      ),
    );
  }
}

class foodFavorites extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => foodFavoritesState();
}

class foodFavoritesState extends State<foodFavorites> {
  late Box<Favorites> favoritesBox;
  
  Future<List<Map<String, dynamic>>> fetchFavoriteFood() async {
    final favoriteIds = favoritesBox.values.map((favorite) => int.parse(favorite.id)).toList();
    if (favoriteIds.isEmpty) {
      return [];
    }
    await Supabase.instance.client.auth.signInWithPassword(email: 'hidwidwi@mail.ru', password: 'azUGyX278');
    final response = await Supabase.instance.client.from('food').select();
    final allFoods = List<Map<String, dynamic>>.from(response);
    final favoriteFoods = allFoods.where((food) => favoriteIds.contains(food['id'])).toList();
    return favoriteFoods;
  }

  deleteFromFavorites(int index) {
  final favoriteKey = favoritesBox.keys.firstWhere(
    (key) => favoritesBox.get(key)?.id == index.toString(),
    orElse: () => null,
  );
  if (favoriteKey != null) {
    favoritesBox.delete(favoriteKey);
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Любимые продукты'),
        backgroundColor: Colors.blue.shade900,
        automaticallyImplyLeading: false,
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade900),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => foodCategories()),
                );
              },
              child: const Text(
                  'В категории',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
            ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchFavoriteFood(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } 
          else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } 
          else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Нет данных'));
          }
          final favoriteFoods = snapshot.data!;
          return ListView.builder(
            itemCount: favoriteFoods.length,
            itemBuilder: (context, index) {
              final food = favoriteFoods[index];
              return Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row( 
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Text(
                        food['name'],
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          ),
                        ),
                        ValueListenableBuilder(
                          valueListenable: favoritesBox.listenable(),
                          builder: (context, Box<Favorites> box, _) {
                            final isFavorite = box.values.any((favorite) => favorite.id == food['id'].toString());
                            return IconButton(
                              iconSize: 30,
                              onPressed: () {
                                deleteFromFavorites(food['id']);
                              },
                              icon: Icon(isFavorite ? Icons.favorite : Icons.heart_broken_sharp),
                            );
                          },
                        ),
                      ],
                    ),
                    GestureDetector(
                      onDoubleTap: () {
                        deleteFromFavorites(food['id']);
                      },
                      child: SizedBox(
                        width: 250,
                        height: 150,
                        child: Image.network(food['photo']),
                      ),
                    ),
                    Text(
                      food['callories'] + ' ' + 'на 100 гр',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      'Белки: ' + food['belki'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      'Жиры: ' + food['zhiry'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      'Углеводы: ' + food['uglevody'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      'Вода: ' + food['water'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      food['poleznost'] + '\n',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ]
                ),
              );
            },
          );
        },
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    favoritesBox = Hive.box<Favorites>('foodFavorites');
  }
}