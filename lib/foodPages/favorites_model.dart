import 'package:hive/hive.dart';
 
part 'favorites_model.g.dart';
 
@HiveType(typeId: 1)
class Favorites {
  @HiveField(0)
  late String id;
  Favorites({required this.id});
}