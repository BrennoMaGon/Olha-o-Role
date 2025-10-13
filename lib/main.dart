import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/event.dart'; // Importe seus modelos
import 'screens/event_list_screen.dart';

void main() async {
  // Garante que o Flutter está inicializado
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o Hive
  await Hive.initFlutter();

  // Registra os adaptadores gerados
  Hive.registerAdapter(EventAdapter());
  Hive.registerAdapter(ItemAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Olha o Rolê',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const EventListScreen(),
    );
  }
}