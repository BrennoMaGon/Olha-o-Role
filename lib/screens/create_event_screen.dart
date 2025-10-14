import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'add_items_screen.dart';
import 'dart:math'; // Adicione este import para gerar ID aleatório

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _peopleCountController = TextEditingController();
  final _dateController = TextEditingController();

  // Método para gerar ID único do evento
  String _generateEventId() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return List.generate(6, (index) => chars[random.nextInt(chars.length)]).join();
  }

  // Método para validar os campos
  bool _validateFields() {
    if (_titleController.text.isEmpty) {
      _showErrorDialog('Por favor, insira um título para o evento');
      return false;
    }
    if (_dateController.text.isEmpty) {
      _showErrorDialog('Por favor, insira uma data para o evento');
      return false;
    }
    return true;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color.fromARGB(255, 230, 210, 185),
        title: const Text(
          'Atenção',
          style: TextStyle(
            color: Color.fromARGB(255, 63, 39, 28),
            fontFamily: 'Itim',
          ),
        ),
        content: Text(
          message,
          style: const TextStyle(
            color: Color.fromARGB(255, 63, 39, 28),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'OK',
              style: TextStyle(
                color: Color.fromARGB(255, 63, 39, 28),
                fontFamily: 'Itim',
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _peopleCountController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 210, 185),
      appBar: AppBar(
        foregroundColor: const Color.fromARGB(255, 63, 39, 28),
        backgroundColor: const Color.fromARGB(255, 211, 173, 92),
        title: const Text('Crie seu evento',
              style: TextStyle(
                color: Color.fromARGB(255, 63, 39, 28),
                fontFamily: 'Itim',
                fontSize: 30)
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Campo Título
            TextField(
              controller: _titleController,
              style: const TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                labelText: 'Título do Evento',
                labelStyle: const TextStyle(color: Colors.black54),
                prefixIcon: const Icon(Icons.festival, color: Colors.black54),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Campo Descrição
            TextField(
              controller: _descriptionController,
              style: const TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                labelText: 'Descrição do Evento',
                labelStyle: const TextStyle(color: Colors.black54),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            
            // Campo Quantidade de Pessoas (APENAS NÚMEROS)
            TextField(
              controller: _peopleCountController,
              style: const TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                labelText: 'Quantidade de Pessoas',
                labelStyle: const TextStyle(color: Colors.black54),
                prefixIcon: const Icon(Icons.people_outline, color: Colors.black54),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            const SizedBox(height: 24),
            
            // Campo Data (FORMATO DD/MM/AAAA)
            TextField(
              controller: _dateController,
              style: const TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                labelText: 'Data do Evento',
                labelStyle: const TextStyle(color: Colors.black54),
                hintText: 'DD/MM/AAAA',
                hintStyle: const TextStyle(color: Colors.black38),
                prefixIcon: const Icon(Icons.calendar_today, color: Colors.black54),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
                LengthLimitingTextInputFormatter(10),
                _DateInputFormatter(),
              ],
            ),
            const SizedBox(height: 40),
            
            // Botão Avançar - ATUALIZADO
            ElevatedButton(
              onPressed: () {
                if (_validateFields()) {
                  // Gera um ID único para o evento
                  final eventId = _generateEventId();
                  
                  // NAVEGA PARA A PRÓXIMA TELA PASSANDO TODOS OS DADOS
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddItemsScreen(
                        eventId: eventId,
                        eventName: _titleController.text,
                        eventDescription: _descriptionController.text, // NOVO
                        eventDate: _dateController.text,               // NOVO
                        peopleCount: int.tryParse(_peopleCountController.text) ?? 0, // NOVO
                      ),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 63, 39, 28),
                backgroundColor: Color.fromARGB(255, 211, 173, 92),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'Itim',
                ),
                
              ), child: Text( 'Avançar',
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Itim',
              ),
              ),
        ),
        ],
        ),
      ),
    );
  }
}

// Formatador personalizado para data (adiciona barras automaticamente)
class _DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    
    // Remove todas as barras para processar
    final digitsOnly = text.replaceAll('/', '');
    
    // Não faz nada se estiver apagando
    if (newValue.text.length < oldValue.text.length) {
      return newValue;
    }
    
    // Formata a data
    String formatted = '';
    for (int i = 0; i < digitsOnly.length && i < 8; i++) {
      if (i == 2 || i == 4) {
        formatted += '/';
      }
      formatted += digitsOnly[i];
    }
    
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}