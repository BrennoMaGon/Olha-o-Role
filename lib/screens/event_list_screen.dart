import 'package:flutter/material.dart';
import 'create_event_screen.dart';


class EventListScreen extends StatelessWidget {
  const EventListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Color(0xFF62216C),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(223, 76, 25, 83),
        centerTitle: true,
        title: const Text('Eventos'),
        actions: [
          IconButton(
            onPressed: () {
              // Lógica para menu ou configurações
            },
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.png"),
            fit: BoxFit.cover,
            opacity: 0.1 // Preenche todo o espaço do container
          ),
          
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Aqui seriam exibidos os eventos, usando um ListView.builder por exemplo
            const Expanded(
              child: Center(
                child:
                
                Text('Nenhum evento por aqui ainda!', style: TextStyle(color: Colors.white,fontFamily: 'ComicNeue', fontSize: 25)),
              ),
                ), Card(
      // O Card já é branco e tem bordas arredondadas por padrão
                  elevation: 4.0, // Controla a sombra
                    margin: const EdgeInsets.all(16.0), // Espaçamento externo do card
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0), // Espaçamento interno
        child: Column( // 1. Use uma Column para organizar os widgets verticalmente
          mainAxisSize: MainAxisSize.min, // Faz o Card se ajustar ao conteúdo
          children: [ // 2. Coloque sua lista de widgets aqui dentro
            ListTile(
              leading: const Icon(Icons.add, size: 28),
              title: const Text('Criar Evento', style: TextStyle(fontSize: 18)),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateEventScreen()));
                print('Criar Evento pressionado!');
              },
            ),
            ListTile(
              leading: const Icon(Icons.arrow_forward, size: 28),
              title: const Text('Ingressar em um evento', style: TextStyle(fontSize: 18)),
              onTap: () {
                print('Botão "Ingressar" pressionado!');
              },
            ),
            ListTile(
              leading: const Icon(Icons.people_outline, size: 28),
              title: const Text('Amigos', style: TextStyle(fontSize: 18,decoration: TextDecoration.lineThrough)),
              trailing: const Text("Em Desenvolvimento",style: TextStyle(fontSize: 12)),
              
            ),
            // O seu espaçamento extra no final
            
          ],
        ),
      ),
    ),const Padding(padding: EdgeInsets.only(bottom: 20)),
          ],
        ),
      ),
      // BottomNavigationBar ou similar para as abas "Eventos", "Amigos", etc.
    );
  }
}