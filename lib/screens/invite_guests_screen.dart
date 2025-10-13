import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'event_list_screen.dart'; // Importe o EventListScreen
import '../models/event.dart'; // Certifique-se de que Event e EventItem estão aqui

class InviteGuestsScreen extends StatelessWidget {
  final String eventName;
  final String eventDescription;
  final int eventPeopleCount;
  // Está recebendo um DateTime, que deve vir da AddItemsScreen
  final DateTime eventDate; 
  final String eventId;
  final List<EventItem> eventItems; 

  const InviteGuestsScreen({
    super.key,
    required this.eventName,
    required this.eventDescription,
    required this.eventPeopleCount,
    required this.eventDate, // Recebe o DateTime
    required this.eventId,
    required this.eventItems, 
  });
  
  String _generateInviteLink() {
    // Lógica para gerar um código aleatório de 8 caracteres
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    final code = List.generate(8, (index) => chars[random.nextInt(chars.length)]).join();
    // Utiliza o código no link
    return 'https://olhaorole.app/evento/$code';
  }

  void _showLinkDialog(BuildContext context) {
    final link = _generateInviteLink();
    
    // Diálogo estilizado para mostrar e copiar o link
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
            // Contêiner para exibir o link de forma selecionável
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
            // Botão para copiar o link
            ElevatedButton.icon(
              onPressed: () {
                // Copia o link para a área de transferência
                Clipboard.setData(ClipboardData(text: link));
                // Exibe uma SnackBar de confirmação
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
          // Botão para fechar o diálogo
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
        title: const Text('Adicione Convidados'), // Título mais descritivo
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.people_alt, // Ícone que representa convidados
              size: 100,
              color: Color.fromARGB(255, 211, 173, 92),
            ),
            const SizedBox(height: 20),
            Text(
              'Convide seus amigos para o evento "${eventName}"',
              style: const TextStyle(
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
              label: const Text('Gerar Link de Convite'),
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
            const SizedBox(height: 10),
             // Mensagem informativa
            const Text(
              'O link de convite permite que seus amigos entrem no evento.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),

            const Spacer(),
            
            // Botão Finalizar
            ElevatedButton(
              onPressed: () {
                // Cria o objeto Event COMPLETO com todos os dados
                final newEvent = Event(
                  id: eventId,
                  name: eventName,
                  description: eventDescription, 
                  peopleCount: eventPeopleCount, 
                  // CORREÇÃO: Converte o DateTime (recebido) para a String "AAAA-MM-DD"
                  // esperada pelo modelo 'Event'
                  eventDate: eventDate.toIso8601String().substring(0, 10), 
                  createdAt: DateTime.now(),
                  items: eventItems, 
                );
                
                // Navega de volta para o EventListScreen passando o evento e removendo
                // todas as telas anteriores da pilha.
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventListScreen.withEvent(newEvent),
                  ),
                  (route) => false, // Remove todas as telas da pilha
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 211, 173, 92), // Cor destacada
                foregroundColor: const Color.fromARGB(255, 63, 39, 28),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
              ),
              child: const Text(
                'Finalizar Criação do Evento',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}