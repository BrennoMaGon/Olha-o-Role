// models/event.dart

import 'dart:convert'; // Importe para o JSON

// Assumindo que você tem também um modelo para EventItem
class EventItem {
  final String name;
  final int quantity;

  EventItem({required this.name, required this.quantity});

  // Converte EventItem em um Map (JSON)
  Map<String, dynamic> toJson() => {
    'name': name,
    'quantity': quantity,
  };

  // Cria um EventItem a partir de um Map (JSON)
  factory EventItem.fromJson(Map<String, dynamic> json) => EventItem(
    name: json['name'] as String,
    quantity: json['quantity'] as int,
  );
}


class Event {
  final String id;
  final String name;
  final String description;
  final int peopleCount;
  final String eventDate; // Formato "AAAA-MM-DD"
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

  // 1. Converte Evento em um Map (JSON)
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'peopleCount': peopleCount,
    'eventDate': eventDate,
    'createdAt': createdAt.toIso8601String(), // Salva DateTime como string
    'items': items.map((i) => i.toJson()).toList(), // Converte a lista de itens
  };

  // 2. Cria um Evento a partir de um Map (JSON)
  factory Event.fromJson(Map<String, dynamic> json) => Event(
    id: json['id'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    peopleCount: json['peopleCount'] as int,
    eventDate: json['eventDate'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String), // Reconverte para DateTime
    items: (json['items'] as List<dynamic>)
        .map((i) => EventItem.fromJson(i as Map<String, dynamic>))
        .toList(),
  );
}