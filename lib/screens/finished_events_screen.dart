import 'package:flutter/material.dart';

// Modelo simples para representar um evento
class Event {
  final String name;
  final String creator;
  final String date;

  Event({required this.name, required this.creator, required this.date});
}

class FinishedEventsScreen extends StatelessWidget {
  const FinishedEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de exemplo de eventos finalizados. Em um app real, viria de um banco de dados.
    final List<Event> finishedEvents = [
      Event(name: 'Churrasco da turma', creator: 'Ana', date: '05/10'),
      Event(name: 'Aniversário do Léo', creator: 'Leo', date: '28/09'),
      Event(name: 'Festa à Fantasia', creator: 'Julia', date: '15/09'),
    ];

    // Para testar a tela vazia (Página 13), use a linha abaixo no lugar da de cima:
    // final List<Event> finishedEvents = [];

    return Scaffold(
      appBar: AppBar(
        // O título da AppBar muda dependendo se há eventos ou não, como no PDF.
        title: Text(finishedEvents.isEmpty ? 'Eventos' : 'Eventos Finalizados'),
        // Aqui poderiam entrar as abas "Próximos" e "Finalizados"
      ),
      body: finishedEvents.isEmpty
          ? const Center(
              child: Text(
                'Não há eventos!', // [cite: 130]
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: finishedEvents.length,
              itemBuilder: (context, index) {
                final event = finishedEvents[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    title: Text(
                      event.name, // [cite: 143, 145, 147]
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('${event.creator} - ${event.date}'), // [cite: 144, 146, 148]
                    onTap: () {
                      // Ação ao tocar em um evento finalizado (ex: ver detalhes, memórias, etc.)
                    },
                  ),
                );
              },
            ),
    );
  }
}