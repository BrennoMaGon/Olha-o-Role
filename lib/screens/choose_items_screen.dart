import 'package:flutter/material.dart';
import 'event_progress_screen.dart';

class ChooseItemsScreen extends StatefulWidget {
  const ChooseItemsScreen({super.key});

  @override
  _ChooseItemsScreenState createState() => _ChooseItemsScreenState();
}

class _ChooseItemsScreenState extends State<ChooseItemsScreen> {
  final Map<String, bool> _items = {
    'Item 1': false, // [cite: 89]
    'Item 2': false, // [cite: 90]
    'Item 3': false, // [cite: 92]
    'Item 4': false, // [cite: 93]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nome do Evento'), // [cite: 85]
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Escolha um ou mais itens da lista para você levar', // [cite: 86]
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: _items.keys.map((String key) {
                  return CheckboxListTile(
                    title: Text(key),
                    value: _items[key],
                    onChanged: (bool? value) {
                      setState(() {
                        _items[key] = value!;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                 Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const EventProgressScreen()),
                  );
              },
              child: const Text('Confirmar'), // [cite: 94]
            ),
          ],
        ),
      ),
    );
  }
}