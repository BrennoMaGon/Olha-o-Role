import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/event.dart'; // Importe o modelo Event E Item

class InviteGuestsScreen extends StatefulWidget {
  final String eventId;
  final String eventName;
  final String eventDescription;
  final String eventDate;
  final int peopleCount;
  final List<Item> items; // Recebe a lista de itens

  const InviteGuestsScreen({
    super.key,
    required this.eventId,
    required this.eventName,
    required this.eventDescription,
    required this.eventDate,
    required this.peopleCount,
    required this.items,
  });

  @override
  State<InviteGuestsScreen> createState() => _InviteGuestsScreenState();
}

// PASSO 2: Crie a classe State e mova toda a lógica para dentro dela
class _InviteGuestsScreenState extends State<InviteGuestsScreen> {
  
  // O método _generateInviteLink foi movido para cá
  String _generateInviteLink() {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    final code = List.generate(8, (index) => chars[random.nextInt(chars.length)]).join();
    return 'https://olhaorole.app/evento/$code';
  }

  // O método _showLinkDialog foi movido para cá
  void _showLinkDialog(BuildContext context) {
    final link = _generateInviteLink();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // ... O conteúdo do seu AlertDialog continua exatamente o mesmo ...
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
          // ... o conteúdo da sua coluna (ícones, textos, etc.) permanece o mesmo ...
          mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ...
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

            // Botão Finalizar
            ElevatedButton(
              onPressed: () async {
                print("--- Botão Finalizar Pressionado ---");
                
                // GERE O LINK DE CONVITE AQUI PARA SALVÁ-LO
                final inviteLink = _generateInviteLink();

                // CRIE O OBJETO 'Event' COMPLETO COM TODOS OS DADOS
                final newEvent = Event()
                  ..id = widget.eventId
                  ..name = widget.eventName
                  ..createdAt = DateTime.now()
                  ..description = widget.eventDescription
                  ..eventDate = widget.eventDate
                  ..peopleCount = widget.peopleCount
                  ..items = widget.items
                  ..inviteLink = inviteLink;
                
                // ABRA A CAIXA E SALVE O EVENTO
                final eventBox = await Hive.openBox<Event>('events');
                await eventBox.put(newEvent.id, newEvent);

                print("Evento Salvo com Sucesso: ${newEvent.name}");

                if (mounted) { 
                  // VOLTA PARA A PRIMEIRA TELA (EventListScreen)
                  Navigator.of(context).popUntil((route) => route.isFirst);
                }
              },
              style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 211, 173, 92),
                    foregroundColor: const Color.fromARGB(255, 63, 39, 28),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 0,
              ),
              child: const Text(
                'Finalizar',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}