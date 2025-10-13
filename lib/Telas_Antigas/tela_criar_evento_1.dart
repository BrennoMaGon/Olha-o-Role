import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crie seu evento',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CreateEventScreen(),
    );
  }
}

class CreateEventScreen extends StatefulWidget {
  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  TextEditingController _eventTitleController = TextEditingController();
  TextEditingController _eventDescriptionController = TextEditingController();
  TextEditingController _peopleQuantityController = TextEditingController(text: '0');
  TextEditingController _eventDateController = TextEditingController(text: '08/17/2025');

  int _peopleCount = 0;

  @override
  void dispose() {
    _eventTitleController.dispose();
    _eventDescriptionController.dispose();
    _peopleQuantityController.dispose();
    _eventDateController.dispose();
    super.dispose();
  }

  void _incrementPeople() {
    setState(() {
      _peopleCount++;
      _peopleQuantityController.text = _peopleCount.toString();
    });
  }

  void _decrementPeople() {
    setState(() {
      if (_peopleCount > 0) {
        _peopleCount--;
        _peopleQuantityController.text = _peopleCount.toString();
      }
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2025, 8, 17),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _eventDateController.text = '${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC8F5C8), // Cor de fundo semelhante à imagem
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Ação para voltar
          },
        ),
        title: Text(
          'Crie seu evento',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Padrão de fundo (seria um custom painter ou asset de imagem)
          // Por simplicidade, vou usar um Container com uma cor sólida
          // Você pode substituir isso por um CustomPaint para desenhar os rabiscos
          // ou um Image.asset para uma imagem de fundo repetida.
          Positioned.fill(
            child: CustomPaint(
              painter: BackgroundPainter(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 20),
                // Imagem do calendário e taças
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.calendar_month, // Ícone de calendário
                        size: 120,
                        color: Colors.deepPurple[400],
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.orange[400], // Cor de fundo para as taças
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.orange, width: 2)
                          ),
                          child: Icon(
                            Icons.wine_bar, // Ícone que representa as taças
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                _buildTextField(
                  controller: _eventTitleController,
                  labelText: 'Título do Evento',
                  suffixIcon: Icon(Icons.emoji_emotions, color: Colors.grey),
                ),
                SizedBox(height: 16),
                _buildTextField(
                  controller: _eventDescriptionController,
                  labelText: 'Descrição do Evento',
                  maxLines: 3,
                ),
                SizedBox(height: 16),
                _buildPeopleQuantityField(),
                SizedBox(height: 16),
                _buildDateField(context),
                Spacer(), // Empurra o botão "Avançar" para baixo
                ElevatedButton(
                  onPressed: () {
                    // Ação ao pressionar o botão Avançar
                    print('Avançar pressionado!');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple[400], // Cor do botão
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Avançar',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    int? maxLines,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }

  Widget _buildPeopleQuantityField() {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Quantidade de Pessoas',
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: IconButton(
            icon: Icon(Icons.remove, color: Colors.deepPurple[400]),
            onPressed: _decrementPeople,
          ),
        ),
        SizedBox(width: 8),
        Container(
          width: 60,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Center(
            child: Text(
              _peopleQuantityController.text,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(width: 8),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: IconButton(
            icon: Icon(Icons.add, color: Colors.deepPurple[400]),
            onPressed: _incrementPeople,
          ),
        ),
      ],
    );
  }

  Widget _buildDateField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Data do Evento',
          style: TextStyle(fontSize: 12, color: Colors.black54),
        ),
        SizedBox(height: 4),
        GestureDetector(
          onTap: () => _selectDate(context),
          child: AbsorbPointer( // Impede que o TextField receba foco
            child: TextField(
              controller: _eventDateController,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: Icon(Icons.calendar_today, color: Colors.deepPurple[400]),
              ),
              readOnly: true, // Torna o campo somente leitura
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 4.0),
          child: Text(
            'DD/MM/YYYY',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}

// Custom Painter para desenhar os rabiscos no fundo
class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.greenAccent[100]!.withOpacity(0.5) // Cor dos rabiscos
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Exemplo de como desenhar alguns rabiscos.
    // Você pode criar um padrão mais complexo aqui.
    canvas.drawArc(Rect.fromLTWH(20, 50, 50, 50), 0, 3.14, false, paint);
    canvas.drawArc(Rect.fromLTWH(size.width - 70, 100, 50, 50), 3.14, 3.14, false, paint);
    canvas.drawArc(Rect.fromLTWH(80, 200, 70, 70), 0, 3.14 * 1.5, false, paint);
    canvas.drawArc(Rect.fromLTWH(size.width - 100, 300, 60, 60), 3.14 * 0.5, 3.14 * 1.5, false, paint);
    canvas.drawArc(Rect.fromLTWH(20, size.height - 100, 50, 50), 0, 3.14, false, paint);
    canvas.drawArc(Rect.fromLTWH(size.width - 70, size.height - 150, 50, 50), 3.14, 3.14, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}