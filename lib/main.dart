import 'package:flutter/material.dart';
import 'package:habit_hub/firebase_options.dart';
import 'package:habit_hub/models/user_preferences.dart';
import 'package:habit_hub/screens/gender_selection.dart';
import 'package:habit_hub/screens/login_options.dart';
import 'package:habit_hub/screens/home.dart';
import 'package:habit_hub/screens/login.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import './providers/app_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Hub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //Inicializar ruta
      initialRoute: '/',
      //Rutas
      routes: {
        '/': (context) => LoginOptions(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        //Añadir gender_selection
        '/gender_selection': (context) => GenderSelection(userPreferences: UserPreferences()),
      },
    );
  }
}