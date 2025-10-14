import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
// O import do EventListScreen não é estritamente necessário se você fizer o pop,
// mas vamos mantê-lo para referência ao construtor, caso precise.
import 'event_list_screen.dart'; 
import '../models/event.dart'; 

class InviteGuestsScreen extends StatelessWidget {
  final String eventName;
  final String eventDescription;
  final int eventPeopleCount;
  final DateTime eventDate; 
  final String eventId;
  final List<EventItem> eventItems; 

  const InviteGuestsScreen({
    super.key,
    required this.eventName,
    required this.eventDescription,
    required this.eventPeopleCount,
    required this.eventDate, 
    required this.eventId,
    required this.eventItems, 
  });
  
  String _generateInviteLink() {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    final code = List.generate(8, (index) => chars[random.nextInt(chars.length)]).join();
    return 'https://olhaorole.app/evento/$code';
  }

  void _showLinkDialog(BuildContext context) {
    // ... (Mantém o código do showLinkDialog, que está correto)
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
        title: const Text('Adicione Convidados'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.people_alt,
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
                // 1. Cria o objeto Event COMPLETO
                final newEvent = Event(
                  id: eventId,
                  name: eventName,
                  description: eventDescription, 
                  peopleCount: eventPeopleCount, 
                  // Garante o formato 'AAAA-MM-DD'
                  eventDate: eventDate.toIso8601String().substring(0, 10), 
                  createdAt: DateTime.now(),
                  items: eventItems, 
                );
                
                // 2. Retorna o novo evento para a tela anterior (CreateEventScreen ou AddItemsScreen)
                // Usando `Navigator.pop` com o resultado.
                // Isso sinaliza que o fluxo de criação terminou com sucesso.
                // As telas anteriores na pilha devem ter o código para tratar este resultado
                // e, em seguida, fazer o pop de volta para a EventListScreen.
                // IMPORTANTE: Se esta é a última tela antes da EventListScreen, 
                // você precisa garantir que ela volte para a raiz.

                // Opção mais simples (menos linhas, exige ajuste nas outras telas):
                // Navigator.pop(context, newEvent); 

                // Opção que força o retorno à EventListScreen (sua raiz) e passa o evento:
                // Usaremos pushAndRemoveUntil, mas a EventListScreen deve usar o 
                // construtor padrão, e você deve retornar o evento para a Home.

                // Melhor Opção para o seu caso (Zerar a pilha e ir para a Home):
                // Retorna para a tela de lista de eventos e REMOVE TODAS as telas 
                // de criação da pilha, passando o evento para ser adicionado.
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    // Passa o novo evento para que EventListScreen o adicione à lista carregada.
                    builder: (context) => EventListScreen.withEvent(newEvent),
                  ),
                  (route) => route.isFirst, // Mantém a tela raiz/home (se EventListScreen for a primeira)
                );
                
                // NOTA: Se EventListScreen não for a primeira (isFirst), mude para `(route) => false`
                // O código na EventListScreen está preparado para receber e salvar o `initialEvent`.
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 211, 173, 92),
                foregroundColor: Colors.white,
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
                  color: Color.fromARGB(255, 63, 39, 28),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}