import 'package:flutter/material.dart';
import 'create_event_screen.dart';

// Reutilizando o modelo de Evento
class Event {
  final String name;
  final String creator;
  final String date;

  Event({required this.name, required this.creator, required this.date});
}


class MyEventsScreen extends StatelessWidget {
  const MyEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de exemplo. Em um app real, viria de um banco de dados filtrado pelo ID do usuário.
    final List<Event> myEvents = [
      Event(name: 'Noite do Pijama', creator: 'Você', date: '25/10'),
      Event(name: 'Trilha no Pico do Jaraguá', creator: 'Você', date: '02/11'),
    ];

    // Para testar a tela vazia (Página 16), use a linha abaixo no lugar da de cima:
    // final List<Event> myEvents = [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus eventos'), // [cite: 155, 166]
      ),
      body: Stack(
        children: [
          if (myEvents.isEmpty)
            const Center(
              child: Text(
                'Não há eventos!', // [cite: 168]
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          else
            ListView.builder(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 80.0), // Padding no final para não sobrepor o botão
              itemCount: myEvents.length,
              itemBuilder: (context, index) {
                final event = myEvents[index];
                return Card(
                   elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    title: Text(
                      event.name, // [cite: 156, 158, 160]
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('${event.creator} - ${event.date}'), // [cite: 157, 159, 161]
                     onTap: () {
                      // Navegar para a tela de progresso/detalhes do evento
                    },
                  ),
                );
              },
            ),
          // Posiciona o botão no final da tela
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CreateEventScreen()),
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Criar Evento'), // [cite: 163, 173]
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}