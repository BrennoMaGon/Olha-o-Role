import 'package:flutter/material.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({Key? key}) : super(key: key);

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: _buildDrawer(),
      body: Stack(
        children: [
          // Background com gradiente roxo
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF9333EA),
                  Color(0xFFA855F7),
                  Color(0xFF7E22CE),
                ],
              ),
            ),
          ),
          
          // Padrão decorativo de confetes
          CustomPaint(
            size: Size.infinite,
            painter: ConfettiPainter(),
          ),
          
          Column(
            children: [
              // Header
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.menu, color: Colors.white, size: 28),
                        onPressed: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                      ),
                      Expanded(
                        child: Text(
                          'Eventos',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 48), // Para balancear o menu icon
                    ],
                  ),
                ),
              ),
              
              // Card central com opções
              Expanded(
                child: Center(
                  child: Container(
                    margin: EdgeInsets.all(24),
                    constraints: BoxConstraints(maxWidth: 400),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildOptionButton(
                          icon: Icons.add,
                          title: 'Criar Evento',
                          onTap: () {
                            // Navegar para tela de criar evento
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Criar Evento - Em desenvolvimento')),
                            );
                          },
                        ),
                        Divider(height: 1),
                        _buildOptionButton(
                          icon: Icons.arrow_forward,
                          title: 'Ingressar em um evento',
                          onTap: () {
                            // Navegar para tela de ingressar
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Ingressar em evento - Em desenvolvimento')),
                            );
                          },
                        ),
                        Divider(height: 1),
                        _buildOptionButton(
                          icon: Icons.group,
                          title: 'Amigos',
                          onTap: () {
                            // Navegar para tela de amigos
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Amigos - Em desenvolvimento')),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Menu',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ),
            _buildDrawerItem(
              icon: Icons.event_available,
              title: 'Eventos Ativos',
              badge: '24',
              isSelected: true,
            ),
            _buildDrawerItem(
              icon: Icons.group,
              title: 'Meus Eventos',
            ),
            _buildDrawerItem(
              icon: Icons.schedule,
              title: 'Atividade',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    String? badge,
    bool isSelected = false,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? Colors.grey[200] : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.grey[700],
          size: 22,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: Colors.grey[800],
          ),
        ),
        trailing: badge != null
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Color(0xFF9333EA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  badge,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              )
            : null,
        onTap: () {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$title selecionado')),
          );
        },
      ),
    );
  }

  Widget _buildOptionButton({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFFF3E8FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: Color(0xFF9333EA),
                size: 24,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Painter para o padrão de confetes
class ConfettiPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    // Desenhar padrão de ~ e ? aleatoriamente
    for (double x = 0; x < size.width; x += 80) {
      for (double y = 0; y < size.height; y += 80) {
        textPainter.text = TextSpan(
          text: (x + y) % 3 == 0 ? '~' : '?',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white.withOpacity(0.15),
          ),
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(x, y));
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}