import 'package:flutter/material.dart';
import 'create_event_screen.dart';

class EventListScreen extends StatelessWidget {
  const EventListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 210, 185),
      appBar: AppBar(
        foregroundColor: const Color.fromARGB(255, 63, 39, 28),
        backgroundColor: const Color.fromARGB(255, 211, 173, 92),
        centerTitle: false,
        title: const Text('Eventos',
            style: TextStyle(
                color: Color.fromARGB(255, 63, 39, 28),
                fontFamily: 'Itim',
                fontSize: 30)),
        actions: [
          IconButton(
            onPressed: () {
              // Lógica para menu ou configurações
            },
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      
      // 1. Adicione a propriedade 'drawer' aqui
      drawer: Drawer(
        child: ListView(
          // Importante: Remova qualquer padding do ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            // 2. DrawerHeader para o cabeçalho (opcional, mas recomendado)
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 211, 173, 92), // Cor de fundo do cabeçalho
              ),
              child: Text(
                'Menu Principal',
                style: TextStyle(
                  color: Color.fromARGB(255, 63, 39, 28),
                  fontSize: 24,
                  fontFamily: 'Itim',
                ),
              ),
            ),
            
            // 3. Itens do menu usando ListTile
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Início'),
              onTap: () {
                // Lógica para navegar para a tela inicial
                // Fecha o drawer após o toque
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () {
                // Lógica para navegar para a tela de perfil
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configurações'),
              onTap: () {
                // Lógica para navegar para a tela de configurações
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      body: Container(
        // O resto do seu código do body permanece o mesmo...
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/background.png"),
              fit: BoxFit.cover,
              opacity: 0.18),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Expanded(
              child: Center(
                child: Text('Nenhum evento por aqui ainda!',
                    style: TextStyle(
                        color: Color.fromARGB(255, 63, 39, 28),
                        fontFamily: 'Itim',
                        fontSize: 25)),
              ),
            ),
            Card(
              elevation: 4.0,
              margin: const EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.add, size: 28),
                      title: const Text('Criar Evento',
                          style: TextStyle(fontSize: 18)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CreateEventScreen()));
                        print('Criar Evento pressionado!');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.arrow_forward, size: 28),
                      title: const Text('Ingressar em um evento',
                          style: TextStyle(fontSize: 18)),
                      onTap: () {
                        print('Botão "Ingressar" pressionado!');
                      },
                    ),
                    const ListTile(
                      leading: Icon(Icons.people_outline, size: 28),
                      title: Text('Amigos',
                          style: TextStyle(
                              fontSize: 18,
                              decoration: TextDecoration.lineThrough)),
                      trailing:
                          Text("Em Desenvolvimento", style: TextStyle(fontSize: 12)),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 20)),
          ],
        ),
      ),
    );
  }
}