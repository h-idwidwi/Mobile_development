import 'package:hive/hive.dart';

part 'news_model.g.dart';

@HiveType(typeId: 2)
class News {
  @HiveField(0)
  DateTime newsDate;
  @HiveField(1)
  String newsId;
  @HiveField(2)
  String newsTitle;
  @HiveField(3)
  String newsDescription;
  News({required this.newsDate, required this.newsId, required this.newsTitle, required this.newsDescription});
}
