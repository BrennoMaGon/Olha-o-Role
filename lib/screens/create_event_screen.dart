import 'package:flutter/material.dart';
import 'add_items_screen.dart';

// 1. Transformado em StatefulWidget
class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  // 2. Controllers para gerenciar o texto de cada campo
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _peopleCountController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  void dispose() {
    // 3. Limpeza dos controllers para evitar vazamento de memória
    _titleController.dispose();
    _descriptionController.dispose();
    _peopleCountController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // O AppBar e o backgroundColor já vêm do tema!
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crie seu evento'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // VEJA COMO OS TEXTFIELDS FICARAM MAIS LIMPOS!
            // Todo o estilo (cores, bordas) vem do tema.
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Título do Evento',
                prefixIcon: Icon(Icons.festival),
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Descrição do Evento',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _peopleCountController,
              decoration: const InputDecoration(
                labelText: 'Quantidade de Pessoas',
                prefixIcon: Icon(Icons.people_outline),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(
                labelText: 'Data do Evento',
                hintText: 'DD/MM/AAAA',
                prefixIcon: Icon(Icons.calendar_today),
              ),
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              // O estilo do botão também vem do tema!
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