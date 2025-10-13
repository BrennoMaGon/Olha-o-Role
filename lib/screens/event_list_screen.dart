import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'create_event_screen.dart';
import '../models/event.dart';

class EventListScreen extends StatefulWidget {
  const EventListScreen({super.key});

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  // Variável para guardar a referência ao Future que abre a caixa.
  // Isso garante que a operação de abrir a caixa só será executada UMA VEZ.
  late final Future<Box<Event>> _eventsBoxFuture;

  @override
  void initState() {
    super.initState();
    // Inicializamos o Future aqui, no initState.
    _eventsBoxFuture = _openEventsBox();
  }

  /// Método auxiliar para abrir a caixa de eventos de forma segura.
  Future<Box<Event>> _openEventsBox() async {
    if (Hive.isBoxOpen('events')) {
      return Hive.box<Event>('events');
    } else {
      return await Hive.openBox<Event>('events');
    }
  }

  @override
  Widget build(BuildContext context) {
    // O seu método build original está correto e permanece aqui...
    // Ele usa o FutureBuilder e o ValueListenableBuilder para construir a lista
    // e chama o _buildEventCard para cada item.
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
            Expanded(
              child: FutureBuilder<Box<Event>>(
                future: _eventsBoxFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                        child: Text(
                            'Erro ao carregar eventos: ${snapshot.error}'));
                  }

                  final eventBox = snapshot.data!;
                  return ValueListenableBuilder(
                    valueListenable: eventBox.listenable(),
                    builder: (context, Box<Event> box, _) {
                      final events = box.values.toList().cast<Event>();

                      if (events.isEmpty) {
                        return const Center(
                          child: Text('Nenhum evento por aqui ainda!',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 63, 39, 28),
                                  fontFamily: 'Itim',
                                  fontSize: 25)),
                        );
                      }
                      
                      events.sort((a, b) => b.createdAt.compareTo(a.createdAt));

                      return ListView.builder(
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          // Chamando a versão CORRETA e ÚNICA do _buildEventCard
                          return _buildEventCard(events[index]);
                        },
                      );
                    },
                  );
                },
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
                              builder: (context) => const CreateEventScreen()),
                        );
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
                      trailing: Text("Em Desenvolvimento",
                          style: TextStyle(fontSize: 12)),
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

  // MANTEMOS APENAS ESTA VERSÃO do _buildEventCard
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
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              'Data: ${event.eventDate ?? "Não definida"}',
              style: const TextStyle(
                color: Colors.black54,
                fontFamily: 'Itim',
              ),
            ),
            Text(
              'Itens na lista: ${event.items.length}',
              style: const TextStyle(
                color: Colors.black54,
                fontFamily: 'Itim',
              ),
            ),
          ],
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

  // Método ATUALIZADO para mostrar todos os detalhes do evento
  void _navigateToEventDetails(Event event) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color.fromARGB(255, 230, 210, 185),
        title: Text(
          event.name,
          style: const TextStyle(
            color: Color.fromARGB(255, 63, 39, 28),
            fontFamily: 'Itim',
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                'Descrição: ${event.description ?? "Nenhuma descrição"}',
                style: const TextStyle(fontFamily: 'Itim'),
              ),
              const SizedBox(height: 8),
              Text(
                'Data do Evento: ${event.eventDate ?? "Não definida"}',
                style: const TextStyle(fontFamily: 'Itim'),
              ),
              const SizedBox(height: 8),
              Text(
                'Quantidade de Pessoas: ${event.peopleCount ?? "Não informado"}',
                style: const TextStyle(fontFamily: 'Itim'),
              ),
              const SizedBox(height: 16),
              const Text(
                'Lista de Itens:',
                style: TextStyle(fontFamily: 'Itim', fontWeight: FontWeight.bold),
              ),
              const Divider(),
              ...event.items.map(
                (item) => Text(
                  '• ${item.name} (Qtd: ${item.quantity})',
                  style: const TextStyle(fontFamily: 'Itim'),
                ),
              ),
              if (event.items.isEmpty)
                const Text(
                  'Nenhum item na lista.',
                  style: TextStyle(fontFamily: 'Itim', fontStyle: FontStyle.italic),
                ),
            ],
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