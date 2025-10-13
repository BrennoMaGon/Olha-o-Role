import 'package:flutter/material.dart';
import 'event_list_screen.dart';


class ProfileSetupScreen extends StatelessWidget {
  const ProfileSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crie sua conta'),
         backgroundColor: const Color(0xFF3D4A9C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                const CircleAvatar(
                  radius: 80,
                  backgroundColor: Color(0xFFD3CFF8),
                  child: Icon(
                    Icons.person,
                    size: 100,
                    color: Color(0xFF4A3F99),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Lógica para editar a foto de perfil
                  },
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Nome de exibição:',
                helperText: 'Não coloque caracteres especiais: @, !, ?',
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const EventListScreen()),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}