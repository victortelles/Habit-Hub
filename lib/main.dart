// main.dart
import 'package:flutter/material.dart';
import './screens/home.dart'; // Asegúrate de que la ruta sea correcta

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plantilla App Movil',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 95, 163, 236),
        ),
        useMaterial3: true,
      ),
      home: HomeScreen(), // Aquí se está utilizando MyHomePage desde home.dart
    );
  }
}
