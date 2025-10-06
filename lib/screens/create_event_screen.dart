import 'package:flutter/material.dart';
import 'add_items_screen.dart';

class CreateEventScreen extends StatelessWidget {
  const CreateEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crie seu evento'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Título do Evento',
                suffixIcon: Icon(Icons.emoji_emotions_outlined), // Representa o Emoji
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(labelText: 'Descrição do Evento'),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(labelText: 'Quantidade de Pessoas'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
             const TextField(
              decoration: InputDecoration(
                labelText: 'Data do Evento',
                hintText: 'DD/MM/YYYY'
              ),
              keyboardType: TextInputType.datetime,
            ),
             const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => const AddItemsScreen()));
              },
              child: const Text('Avançar'),
            )
          ],
        ),
      ),
    );
  }
}