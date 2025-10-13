import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'event_list_screen.dart'; // Importe o EventListScreen
import '../models/event.dart';

class InviteGuestsScreen extends StatelessWidget {
  final String eventName;
  final String eventId;

  const InviteGuestsScreen({
    super.key,
    required this.eventName,
    required this.eventId,
  });

  String _generateInviteLink() {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    final code = List.generate(8, (index) => chars[random.nextInt(chars.length)]).join();
    return 'https://olhaorole.app/evento/$code';
  }

  void _showLinkDialog(BuildContext context) {
    final link = _generateInviteLink();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color.fromARGB(255, 230, 210, 185),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'Link de Convite Gerado',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.link,
              size: 60,
              color: Color.fromARGB(255, 211, 173, 92),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: SelectableText(
                link,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: link));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Link copiado para a área de transferência!'),
                    backgroundColor: Colors.green.shade700,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.copy),
              label: const Text('Copiar Link'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 211, 173, 92),
                foregroundColor: const Color.fromARGB(255, 63, 39, 28),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: Colors.red.shade700,
            ),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 210, 185),
      appBar: AppBar(
        foregroundColor: const Color.fromARGB(255, 63, 39, 28),
        backgroundColor: const Color.fromARGB(255, 211, 173, 92),
        title: const Text('Crie seu evento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.link,
              size: 100,
              color: Color.fromARGB(255, 211, 173, 92),
            ),
            const SizedBox(height: 20),
            const Text(
              'Adicione os convidados do evento',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            
            // Botão Criar Link de Convite
            OutlinedButton.icon(
              onPressed: () => _showLinkDialog(context),
              icon: const Icon(Icons.link),
              label: const Text('Criar Link de Convite'),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 63, 39, 28),
                side: const BorderSide(
                  color: Color.fromARGB(255, 211, 173, 92),
                  width: 2,
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                backgroundColor: Colors.white,
              ),
            ),
            const Spacer(),
            
            // Botão Finalizar - CORRIGIDO
            ElevatedButton(
              onPressed: () {
                // Cria o objeto Event com os dados do evento
                final newEvent = Event(
                  id: eventId,
                  name: eventName,
                  createdAt: DateTime.now(),
                );
                // Navega de volta para o EventListScreen passando o evento
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventListScreen.withEvent(newEvent),
                  ),
                  (route) => false, // Remove todas as telas da pilha
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color.fromARGB(255, 63, 39, 28),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Finalizar',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}