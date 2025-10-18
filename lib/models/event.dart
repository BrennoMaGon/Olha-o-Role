import 'package:hive/hive.dart';

part 'event.g.dart'; // Importante: Este arquivo será gerado automaticamente

@HiveType(typeId: 1) // typeId deve ser único por modelo
class Item extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late int quantity;
}

@HiveType(typeId: 0) // typeId deve ser único por modelo
class Event extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late DateTime createdAt;

  @HiveField(3)
  String? description; // Campos opcionais

  @HiveField(4)
  String? eventDate;

  @HiveField(5)
  int? peopleCount;

  @HiveField(6)
  String? inviteLink;

  @HiveField(7)
  // O Hive precisa saber como lidar com a lista de um tipo personalizado
  late List<Item> items;
}