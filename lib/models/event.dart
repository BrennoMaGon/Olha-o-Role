// lib/models/event.dart
class Event {
  final String id;
  final String name;
  final DateTime createdAt;

  Event({
    required this.id,
    required this.name,
    required this.createdAt,
  });
}