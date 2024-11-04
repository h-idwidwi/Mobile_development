import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_development/foodPages/favorites_model.dart';
import 'package:mobile_development/foodPages/foodCategories.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'foodFavorites.dart';

class FoodBySearch extends StatefulWidget {
  final dynamic name;
  const FoodBySearch(this.name, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => FoodBySearchState();
}

class FoodBySearchState extends State<FoodBySearch> {
  late Box<Favorites> favoritesBox;

  Future<List<Map<String, dynamic>>> getFoodByName(name) async {
    await Supabase.instance.client.auth.signInWithPassword(email: 'hidwidwi@mail.ru', password: 'azUGyX278');
    final response = await Supabase.instance.client.from('food').select().eq('name', name);
    return List<Map<String, dynamic>>.from(response);
  }

  addToFavorites(int index) {
    final exists = favoritesBox.values.any((favorite) => favorite.id == index.toString());
    if (!exists) {
      favoritesBox.add(Favorites(id: index.toString()));
    }
    else {
      return;
    }
    print(favoritesBox.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Справочник продуктов'),
        backgroundColor: Colors.blue.shade900,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 200, 0),
            child: ElevatedButton(
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
          ),
          IconButton(
            icon: Icon(Icons.favorite_outline_rounded),
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => foodFavorites(),
                )
              );
            }
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getFoodByName(widget.name), 
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
          final food = snapshot.data!;
          return ListView.builder(
            itemCount: food.length,
            itemBuilder: ((context, index) {
              final foods = food[index];
              return Padding(
                padding: EdgeInsets.all(10),
                child: 
                  Column(
                    children: [
                      Row( 
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text(
                          foods['name'],
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            ),
                          ),
                          ValueListenableBuilder(
                            valueListenable: favoritesBox.listenable(),
                            builder: (context, Box<Favorites> box, _) {
                              final isFavorite = box.values.any((favorite) => favorite.id == foods['id'].toString());
                              return IconButton(
                                iconSize: 30,
                                onPressed: () {
                                  addToFavorites(foods['id']);
                                },
                                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                              );
                            },
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          addToFavorites(foods['id']);
                        },
                        child: SizedBox(
                          width: 250,
                          height: 150,
                          child: Image.network(foods['photo']),
                        ),
                      ),
                      Text(
                        foods['callories'] + ' ' + 'на 100 гр',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        'Белки: ' + foods['belki'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        'Жиры: ' + foods['zhiry'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        'Углеводы: ' + foods['uglevody'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        'Вода: ' + foods['water'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        foods['poleznost'] + '\n',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ]
                  ),
              );
            }),
          );
        }
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    favoritesBox = Hive.box<Favorites>('foodFavorites');
  }
}