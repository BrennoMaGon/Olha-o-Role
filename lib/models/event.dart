// lib/models/event.dart
class EventItem {
  final String name;
  final int quantity;

  EventItem({
    required this.name,
    required this.quantity,
  });
}

class Event {
  final String id;
  final String name;
  final String description;
  final int peopleCount;
  final String eventDate;
  final DateTime createdAt;
  final List<EventItem> items;

  Event({
    required this.id,
    required this.name,
    required this.description,
    required this.peopleCount,
    required this.eventDate,
    required this.createdAt,
    required this.items,
  });
}