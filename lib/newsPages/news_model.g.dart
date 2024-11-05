// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewsAdapter extends TypeAdapter<News> {
  @override
  final int typeId = 2;

 @override
  News read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return News(
      newsDate: fields[0] as DateTime,
      newsId: fields[1] as String,
      newsTitle: fields[2] as String,
      newsDescription: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, News obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.newsDate)
      ..writeByte(1)
      ..write(obj.newsId)
      ..writeByte(2)
      ..write(obj.newsTitle)
      ..writeByte(3)
      ..write(obj.newsDescription);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
