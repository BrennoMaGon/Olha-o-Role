import 'package:flutter/material.dart';
import 'create_event_screen.dart';
import '../models/event.dart';
class EventListScreen extends StatefulWidget {
  final Event? initialEvent; // Parâmetro opcional para evento inicial

  const EventListScreen({super.key, this.initialEvent});

  // Construtor nomeado para criar a tela com um evento
  const EventListScreen.withEvent(Event event, {super.key}) 
      : initialEvent = event;

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  // Lista de eventos - inicialmente vazia
  List<Event> events = [];

  @override
  void initState() {
    super.initState();
    // Se foi passado um evento inicial, adiciona à lista
    if (widget.initialEvent != null) {
      events.add(widget.initialEvent!);
    }
  }

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
      
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 211, 173, 92),
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
            
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Início'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configurações'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      body: Container(
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
            // Área que mostra eventos ou mensagem de "nenhum evento"
            Expanded(
              child: events.isEmpty
                  ? const Center(
                      child: Text('Nenhum evento por aqui ainda!',
                          style: TextStyle(
                              color: Color.fromARGB(255, 63, 39, 28),
                              fontFamily: 'Itim',
                              fontSize: 25)),
                    )
                  : ListView.builder(
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        return _buildEventCard(events[index]);
                      },
                    ),
            ),
            
            // Cards de ações (criar evento, ingressar, etc.)
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
                        _navigateToCreateEvent(context);
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

  // Método para construir o card do evento
  Widget _buildEventCard(Event event) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 211, 173, 92),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Icon(
            Icons.event,
            color: Color.fromARGB(255, 63, 39, 28),
            size: 30,
          ),
        ),
        title: Text(
          event.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 63, 39, 28),
            fontFamily: 'Itim',
          ),
        ),
        subtitle: Text(
          'ID: ${event.id}',
          style: const TextStyle(
            color: Colors.grey,
            fontFamily: 'Itim',
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Color.fromARGB(255, 63, 39, 28),
          size: 16,
        ),
        onTap: () {
          _navigateToEventDetails(event);
        },
      ),
    );
  }

  // Método para navegar para a tela de criação de evento
  void _navigateToCreateEvent(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateEventScreen()),
    );
    
    // Se um evento foi criado, adicione à lista
    if (result != null && result is Event) {
      setState(() {
        events.add(result);
      });
    }
  }

  // Método para navegar para os detalhes do evento
  void _navigateToEventDetails(Event event) {
    print('Evento clicado: ${event.name} (ID: ${event.id})');
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color.fromARGB(255, 230, 210, 185),
        title: Text(
          event.name,
          style: const TextStyle(
            color: Color.fromARGB(255, 63, 39, 28),
            fontFamily: 'Itim',
          ),
        ),
        content: Text(
          'ID do evento: ${event.id}\nCriado em: ${event.createdAt.toString().split(' ')[0]}',
          style: const TextStyle(
            color: Color.fromARGB(255, 63, 39, 28),
            fontFamily: 'Itim',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Fechar',
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
}