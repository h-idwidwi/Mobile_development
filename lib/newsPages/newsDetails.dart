import 'package:flutter/material.dart';
import 'package:mobile_development/newsPages/newsMain.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NewsDetails extends StatefulWidget {
  final String newId;
  const NewsDetails(this.newId, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => NewsDetailsState();
}

class NewsDetailsState extends State<NewsDetails> {

  Future<List<Map<String, dynamic>>> getNewsById(String newId) async {
    final int id = int.parse(newId);
    await Supabase.instance.client.auth.signInWithPassword(email: 'hidwidwi@mail.ru', password: 'azUGyX278');
    final response = await Supabase.instance.client.from('news').select().eq('id', id);
    return List<Map<String, dynamic>>.from(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
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
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getNewsById(widget.newId), 
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
              return Column(
                children: [ 
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      newsList['title'] ?? 'Без названия',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: SizedBox(
                      child: Image.network(newsList['media'] ?? ''),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      newsList['description'] ?? 'Описание отсутствует',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ]
              );
            }),
          );
        }
      ),
    );
  }
}
