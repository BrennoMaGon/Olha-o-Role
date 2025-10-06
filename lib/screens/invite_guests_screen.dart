import 'package:flutter/material.dart';
import 'event_list_screen.dart';

class InviteGuestsScreen extends StatelessWidget {
  const InviteGuestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crie seu evento'), // [cite: 63]
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.link, size: 100, color: Colors.blueGrey),
            const SizedBox(height: 20),
            const Text(
              'Adicione os convidados do evento', // [cite: 64]
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            OutlinedButton.icon(
              onPressed: () {
                // Lógica para gerar e copiar o link de convite
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Link de convite copiado!')),
                );
              },
              icon: const Icon(Icons.link),
              label: const Text('Criar Link de Convite'), // [cite: 65]
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const EventListScreen()),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text('Finalizar'), // [cite: 69]
            ),
          ],
        ),
      ),
    );
  }
}