import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // NOVO: Importe SharedPreferences
import 'dart:convert'; // Importe para manipulação de JSON

import 'create_event_screen.dart';
import '../models/event.dart';

class EventListScreen extends StatefulWidget {
  final Event? initialEvent;

  const EventListScreen({super.key, this.initialEvent});

  // Construtor nomeado para criar a tela com um evento
  const EventListScreen.withEvent(Event event, {super.key})
      : initialEvent = event;

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  // Chave para salvar/carregar no SharedPreferences
  static const String _eventKey = 'eventList'; 
  
  List<Event> events = [];
  bool _isLoading = true; // Para gerenciar o estado de carregamento inicial

  @override
  void initState() {
    super.initState();
    _loadEvents(); // 1. Carrega eventos persistidos
  }

  /// Carrega a lista de eventos do disco local (SharedPreferences).
  Future<void> _loadEvents() async {
    final prefs = await SharedPreferences.getInstance();
    final String? eventsString = prefs.getString(_eventKey);

    if (eventsString != null) {
      final List<dynamic> eventJson = jsonDecode(eventsString);
      events = eventJson.map((e) => Event.fromJson(e as Map<String, dynamic>)).toList();
    }
    
    // 2. Adiciona o evento inicial (se houver) APÓS carregar os eventos existentes.
    // Isso garante que ele não seja perdido.
    if (widget.initialEvent != null && 
        !events.any((e) => e.id == widget.initialEvent!.id)) {
      events.add(widget.initialEvent!);
      await _saveEvents(); // Salva o novo evento logo após adicioná-lo
    }
    
    // Marca o carregamento como concluído e atualiza a UI
    setState(() {
      _isLoading = false;
    });
  }

  /// Salva a lista de eventos completa no disco local (SharedPreferences).
  Future<void> _saveEvents() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Converte a lista de objetos Event em uma lista de Maps (JSON)
    final List<Map<String, dynamic>> jsonList = events.map((event) => event.toJson()).toList();
    
    // Converte a lista de Maps em uma string JSON para salvar
    final String eventsString = jsonEncode(jsonList);
    
    await prefs.setString(_eventKey, eventsString);
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
              child: _isLoading 
                ? const Center(child: CircularProgressIndicator()) // Mostra loading
                : events.isEmpty
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
    // ... (Mantém o código do Card)
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
    
    // Se um evento foi criado (caso não tenha usado o fluxo InviteGuestsScreen)
    if (result != null && result is Event) {
      setState(() {
        events.add(result);
        _saveEvents(); // **SALVA**
      });
    }
  }

  // Método para navegar para os detalhes do evento
  void _navigateToEventDetails(Event event) {
    // ... (Mantém o código do showDialog)
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color.fromARGB(255, 230, 210, 185),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          event.name,
          style: const TextStyle(
            color: Color.fromARGB(255, 63, 39, 28),
            fontFamily: 'Itim',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Informações básicas do evento
              _buildInfoRow('📅 Data do Evento:', event.eventDate),
              _buildInfoRow('👥 Quantidade de Pessoas:', '${event.peopleCount} pessoas'),
              _buildInfoRow('📝 Descrição:', event.description),
              _buildInfoRow('🆔 ID do Evento:', event.id),
              _buildInfoRow('📋 Data de Criação:', 
                '${event.createdAt.day.toString().padLeft(2, '0')}/'
                '${event.createdAt.month.toString().padLeft(2, '0')}/'
                '${event.createdAt.year}'
              ),
              
              const SizedBox(height: 16),
              
              // Lista de itens
              if (event.items.isNotEmpty) ...[
                const Text(
                  '🛒 Itens do Evento:',
                  style: TextStyle(
                    color: Color.fromARGB(255, 63, 39, 28),
                    fontFamily: 'Itim',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: event.items.asMap().entries.map((entry) {
                      final index = entry.key;
                      final item = entry.value;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 211, 173, 92),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Center(
                                child: Text(
                                  '${index + 1}',
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 63, 39, 28),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                item.name,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 63, 39, 28),
                                  fontFamily: 'Itim',
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 211, 173, 92),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '${item.quantity}x',
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 63, 39, 28),
                                  fontFamily: 'Itim',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ] else ...[
                const Text(
                  '📦 Nenhum item adicionado ao evento',
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Itim',
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 63, 39, 28),
            ),
            child: const Text(
              'Fechar',
              style: TextStyle(
                fontFamily: 'Itim',
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Método auxiliar para construir linhas de informação
  Widget _buildInfoRow(String label, String value) {
    // ... (Mantém o código do _buildInfoRow)
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(
                color: Color.fromARGB(255, 63, 39, 28),
                fontFamily: 'Itim',
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Color.fromARGB(255, 63, 39, 28),
                fontFamily: 'Itim',
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}