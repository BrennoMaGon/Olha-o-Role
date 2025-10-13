import 'package:flutter/material.dart';
import 'choose_items_screen.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nome do Evento'), // [cite: 70]
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Emoji', style: TextStyle(fontSize: 48)), // [cite: 71]
            const SizedBox(height: 16),
            Text('Data do Evento', style: Theme.of(context).textTheme.headlineSmall), // [cite: 72]
            const SizedBox(height: 8),
            Text('Criado por - #Nome do Criador', style: TextStyle(fontStyle: FontStyle.italic)), // [cite: 74]
            const SizedBox(height: 8),
            Text('xx participantes', style: TextStyle(color: Colors.grey)), // [cite: 77]
            const Divider(height: 32),
            const Text('Descrição do Evento', style: TextStyle(fontWeight: FontWeight.bold)), // [cite: 75]
            const SizedBox(height: 8),
            const Text(
              'Aqui vai a descrição detalhada do evento, com todas as informações importantes para os participantes.',
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChooseItemsScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Participar'), // [cite: 81]
              ),
            ),
          ],
        ),
      ),
    );
  }
}