import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_development/newsPages/newsMain.dart';
import 'package:mobile_development/newsPages/news_model.dart';

class NewsRecentlyApp extends StatelessWidget {
  const NewsRecentlyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: NewsRecently(),
      ),
    );
  }
}

class NewsRecently extends StatefulWidget {
  const NewsRecently({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => NewsRecentlyState();
}

class NewsRecentlyState extends State<NewsRecently> {
  late Box<News> newsBox;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Просмотренные новости'),
        backgroundColor: Colors.blue.shade900,
        automaticallyImplyLeading: false,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade900),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewsMain()),
              );
            },
            child: const Text(
                'Новости',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
            ),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: newsBox.listenable(),
        builder: (context, Box<News> box, _) {
          final news = box.values.toList().cast<News>();
          if (news.isEmpty) {
            return Center(child: Text(
              'Нет недавно просмотренных новостей',
              textAlign: TextAlign.center,
              style: TextStyle(
                    fontSize: 30,
                  ),
              )
            );
          }
          return ListView.builder(
            itemCount: news.length,
            itemBuilder: (context, index) {
              final newsList = news[index];
              return ListTile(
                title: Text(
                  newsList.newsTitle,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  newsList.newsDescription + "\n" + newsList.newsDate.toString().substring(0, 19),
                  style: TextStyle(
                    fontSize: 16,
                  ),
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
    newsBox = Hive.box<News>('news');
  }

  @override
  void dispose() {
    newsBox.compact();
    super.dispose();
  }
}