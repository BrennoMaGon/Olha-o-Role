import 'package:flutter/material.dart';
import 'create_event_screen.dart';


class EventListScreen extends StatelessWidget {
  const EventListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eventos'),
        actions: [
          IconButton(
            onPressed: () {
              // Lógica para menu ou configurações
            },
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Aqui seriam exibidos os eventos, usando um ListView.builder por exemplo
            const Expanded(
              child: Center(
                child: Text('Nenhum evento por aqui ainda!'),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                 // Navega para a tela de criação de evento
                 Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateEventScreen()));
              },
              icon: const Icon(Icons.add),
              label: const Text('Criar Evento'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                // Lógica para ingressar em um evento
              },
              child: const Text('Ingressar em um evento'),
            ),
             const SizedBox(height: 20),
             const Text('Amigos', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
             // ListView para amigos
          ],
        ),
      ),
      // BottomNavigationBar ou similar para as abas "Eventos", "Amigos", etc.
    );
  }
}