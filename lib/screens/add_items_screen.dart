import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'invite_guests_screen.dart';
import '../models/event.dart'; // Importa EventItem do seu modelo

// Removida a classe ItemData e usaremos EventItem diretamente

class AddItemsScreen extends StatefulWidget {
  final String eventName;
  final String eventDescription;
  final int eventPeopleCount;
  // Recebe a data como String "DD/MM/AAAA" da CreateEventScreen
  final String eventDate; 
  final String eventId;

  const AddItemsScreen({
    super.key,
    required this.eventName,
    required this.eventDescription,
    required this.eventPeopleCount,
    required this.eventDate,
    required this.eventId,
  });

  @override
  State<AddItemsScreen> createState() => _AddItemsScreenState();
}

class _AddItemsScreenState extends State<AddItemsScreen> {
  // Alterado List<ItemData> para List<EventItem>
  final List<EventItem> _items = [];
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  void _addItem() {
    if (_itemController.text.isNotEmpty && _quantityController.text.isNotEmpty) {
      // Tenta fazer o parse e verifica se é um número
      // NOTA: Se EventItem.quantity espera um double, mude int.tryParse para double.tryParse
      final quantity = int.tryParse(_quantityController.text); 
      
      if (quantity != null && quantity > 0) {
        setState(() {
          _items.add(EventItem( // Cria um EventItem
            name: _itemController.text,
            quantity: quantity.toInt(), 
          ));
          _itemController.clear();
          _quantityController.clear();
          // Esconde o teclado após adicionar
          FocusScope.of(context).unfocus(); 
        });
      } else {
        // Opcional: mostrar um erro se a quantidade for inválida
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, insira uma quantidade válida.')),
        );
      }
    }
  }

  void _editItem(int index) {
    // Armazena o valor original no controller para edição
    _itemController.text = _items[index].name;
    // NOTA: Se quantity é double, use .toString()
    _quantityController.text = _items[index].quantity.toString(); 
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color.fromARGB(255, 230, 210, 185),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Editar Item',
          style: TextStyle(color: Colors.black87),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _itemController,
              style: const TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                labelText: 'Nome do Item',
                labelStyle: const TextStyle(color: Colors.black54),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _quantityController,
              style: const TextStyle(color: Colors.black87),
              keyboardType: TextInputType.number,
              inputFormatters: [
                // Permite apenas dígitos para simplicidade, mas se precisar de decimais, mude para:
                // FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')), 
                FilteringTextInputFormatter.digitsOnly 
              ],
              decoration: InputDecoration(
                labelText: 'Quantidade',
                labelStyle: const TextStyle(color: Colors.black54),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Limpar controllers e fechar o diálogo
              _itemController.clear();
              _quantityController.clear();
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red.shade700,
            ),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              // NOTA: Se quantity é double no modelo, mude para double.tryParse
              final quantity = int.tryParse(_quantityController.text); 

              if (_itemController.text.isNotEmpty && quantity != null && quantity > 0) {
                setState(() {
                  _items[index] = EventItem( // Atualiza o item
                    name: _itemController.text,
                    quantity: quantity.toInt(), // Converte para double, se o modelo espera double
                  );
                });
                _itemController.clear();
                _quantityController.clear();
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 211, 173, 92),
              foregroundColor: const Color.fromARGB(255, 63, 39, 28),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _itemController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  // MÉTODO DE NAVEGAÇÃO CORRIGIDO
  void _navigateToInviteGuests() {
    // 1. Lógica de CONVERSÃO DA DATA: String "DD/MM/AAAA" para objeto DateTime
    final dateString = widget.eventDate;
    final parts = dateString.split('/');
    
    if (parts.length != 3) {
      // Isso teoricamente não deve ocorrer se a validação da tela anterior for boa
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro interno no formato da data.')),
      );
      return;
    }
    
    final day = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final year = int.tryParse(parts[2]);

    if (day == null || month == null || year == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro: Componentes da data não são números válidos.')),
      );
      return;
    }
    
    // O objeto DateTime que será passado para a próxima tela
    final eventDateTime = DateTime(year, month, day);

    // 2. NAVEGAÇÃO: Passando o objeto DateTime
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InviteGuestsScreen(
          eventName: widget.eventName,
          eventDescription: widget.eventDescription,
          eventPeopleCount: widget.eventPeopleCount,
          eventDate: eventDateTime, // <-- AGORA É DATETIME CORRETO
          eventId: widget.eventId,
          eventItems: _items, // Passa a lista de EventItem
        ),
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
        title: const Text('Crie seu evento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Adicione os itens do evento na lista 📝',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            
            // Linha com dois campos: Item e Quantidade
            Row(
              children: [
                // Campo Nome do Item
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _itemController,
                    style: const TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                      labelText: 'Item da Lista',
                      labelStyle: const TextStyle(color: Colors.black54),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onSubmitted: (_) => _addItem(),
                  ),
                ),
                const SizedBox(width: 10),
                
                // Campo Quantidade
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: _quantityController,
                    style: const TextStyle(color: Colors.black87),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      labelText: 'Qtd',
                      labelStyle: const TextStyle(color: Colors.black54),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onSubmitted: (_) => _addItem(),
                  ),
                ),
                const SizedBox(width: 10),
                
                // Botão adicionar (ícone +)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add, color: Color.fromARGB(255, 63, 39, 28)),
                    onPressed: _addItem,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            const Text(
              'Lista de itens',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            
            // Lista de itens
            Expanded(
              child: _items.isEmpty
                  ? const Center(
                        child: Text(
                          'Nenhum item adicionado ainda. É importante para a organização! 😇',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 14,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _items.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              children: [
                                // Nome do item
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Text(
                                      _items[index].name,
                                      style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                
                                // Quantidade
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 211, 173, 92).withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    '${_items[index].quantity}x',
                                    style: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                
                                // Botão editar
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.black54,
                                      size: 20,
                                    ),
                                    onPressed: () => _editItem(index),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                
                                // Botão excluir
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _items.removeAt(index);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
            ),
            const SizedBox(height: 20),
            
            // Botão Avançar - AGORA CHAMA O MÉTODO DE NAVEGAÇÃO CORRETO
            ElevatedButton(
              onPressed: _navigateToInviteGuests,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 211, 173, 92),
                foregroundColor: const Color.fromARGB(255, 63, 39, 28),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
              ),
              child: const Text(
                'Avançar para Convite',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}