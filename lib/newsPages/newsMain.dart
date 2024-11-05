import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mobile_development/main.dart';
import 'package:mobile_development/newsPages/newsDetails.dart';
import 'package:mobile_development/newsPages/newsRecently.dart';
import 'package:mobile_development/newsPages/news_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NewsMainApp extends StatelessWidget {
  const NewsMainApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: NewsMain(),
      ),
    );
  }
}

class NewsMain extends StatefulWidget {
  const NewsMain({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => NewsMainState();
}

class NewsMainState extends State<NewsMain> {
  late Box<News> newsBox;
  int? selectedCategory;
  DateTime? selectedDate;
  bool ascending = false;

  String iconCategories(int cat) {
    switch (cat) {
      case 1:
        return '⚽️';
      case 2:
        return '🎼';
      case 3:
        return '🌐';
      case 4:
        return '🦁';
      case 5:
        return '👩‍🎤';
      default:
        return 'none';
    }
  }

  Future<List<Map<String, dynamic>>> fetchNews() async {
    await Supabase.instance.client.auth.signInWithPassword(email: 'hidwidwi@mail.ru', password: 'azUGyX278');
    var query = Supabase.instance.client.from('news').select();
    if (selectedCategory != null) {
      query = query.filter('category', 'eq', selectedCategory);
    }
    if (selectedDate != null) {
      query = query.filter('date', 'eq', selectedDate);
    }
    final response = await query;
    List<Map<String, dynamic>> newsList = List<Map<String, dynamic>>.from(response);
    if (!ascending) {
      return newsList;
    }
    else {
      return newsList.reversed.toList();
    }
  }

  void addToRecently(DateTime newsDate, int index, String title, String description) {
    final exists = newsBox.values.any((history) => history.newsId == index.toString());
    final newsKey = newsBox.keys.firstWhere((key) => newsBox.get(key)?.newsId == index.toString(), orElse: () => null);
    if (newsBox.length > 20) {
      newsBox.deleteAt(0);
    }
    if (!exists) {
      newsBox.add(News(
        newsDate: newsDate,
        newsId: index.toString(),
        newsTitle: title,
        newsDescription: description,
      ));
    } 
    else {
      newsBox.delete(newsKey);
      newsBox.add(News(
        newsDate: newsDate,
        newsId: index.toString(),
        newsTitle: title,
        newsDescription: description,
      ));
    }
    Navigator.push(context, MaterialPageRoute(builder: (builder) => NewsDetails(index.toString())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 150, 0),
            child: ElevatedButton(
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
          ),
          IconButton(
            icon: Icon(Icons.punch_clock),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewsRecently()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_alt_sharp),
            onPressed: () {
              getFilters();
            },
          ),
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              setState(() {
                ascending = !ascending;
                fetchNews();
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchNews(),
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
          final news = snapshot.data!;
          return ListView.builder(
            itemCount: news.length,
            itemBuilder: ((context, index) {
              final newsList = news[index];
              DateTime newsDate = DateTime.parse(newsList['created_at']);
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => addToRecently(newsDate, newsList['id'], newsList['title'], newsList['description']),
                          child: Text(
                            iconCategories(newsList['category']),
                            style: const TextStyle(fontSize: 30),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => addToRecently(newsDate, newsList['id'], newsList['title'], newsList['description']),
                          child: Text(
                            newsList['title'],
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      DateFormat('dd.MM.yyyy HH:mm:ss').format(newsDate),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              );
            }),
          );
        },
      ),
    );
  }

  void getFilters() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Фильтры"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text("Выберите дату"),
                trailing: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate ?? DateTime.now(),
                      firstDate: DateTime(2024),
                      lastDate: DateTime(2025),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        selectedDate = pickedDate;
                      });
                    }
                  },
                ),
              ),
              DropdownButton<int>(
                hint: Text("Выберите категорию"),
                value: selectedCategory,
                items: [
                  DropdownMenuItem(value: 1, child: Text("Спорт")),
                  DropdownMenuItem(value: 2, child: Text("Шоу-бизнес")),
                  DropdownMenuItem(value: 3, child: Text("Политика")),
                  DropdownMenuItem(value: 4, child: Text("Животные")),
                  DropdownMenuItem(value: 5, child: Text("Культура")),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value!;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Применить"),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  fetchNews();
                });
              },
            ),
            TextButton(
              child: Text("Сбросить"),
              onPressed: () {
                setState(() {
                  selectedDate = null;
                  selectedCategory = null;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    newsBox = Hive.box<News>('news');
  }

  @override
  void dispose() {
    newsBox.compact();
    super.dispose();
  }
}
