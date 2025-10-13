import 'package:flutter/material.dart';

class EventProgressScreen extends StatelessWidget {
  const EventProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nome do Evento'), // [cite: 96]
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Emoji', style: TextStyle(fontSize: 32)), // [cite: 97]
            const SizedBox(height: 8),
            const Text('Data do Evento', style: TextStyle(fontSize: 16)), // [cite: 98]
            const SizedBox(height: 4),
            Text('xx participantes', style: TextStyle(color: Colors.grey)), // [cite: 99]
            const SizedBox(height: 16),
            const Text('Descrição do Evento'), // [cite: 100]
            const Divider(height: 32),
            const Text('Progresso geral:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)), // [cite: 126]
            const SizedBox(height: 8),
            const LinearProgressIndicator(
              value: 0.75, // Valor de exemplo
              minHeight: 10,
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: const [
                  ListTile(
                    leading: CircleAvatar(child: Text('P1')),
                    title: Text('Participante 1'), // [cite: 102]
                    subtitle: Text('Item que ele vai levar'), // [cite: 103]
                  ),
                  ListTile(
                    leading: CircleAvatar(child: Text('P2')),
                    title: Text('Participante 2'), // [cite: 104]
                    subtitle: Text('item comprado'), // [cite: 105]
                  ),
                  ListTile(
                    leading: CircleAvatar(child: Text('P3')),
                    title: Text('Participante 3'), // [cite: 106]
                    subtitle: Text('item comprado'), // [cite: 107]
                  ),
                   ListTile(
                    leading: CircleAvatar(child: Text('P4')),
                    title: Text('Participante 4'), // [cite: 108]
                    subtitle: Text('item comprado'), // [cite: 109]
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}