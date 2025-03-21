import 'package:flutter/material.dart';
import 'package:habit_hub/models/user_preferences.dart';
import 'screens/gender_selection.dart';
import 'package:habit_hub/screens/login_options.dart';
import 'package:provider/provider.dart';
import './screens/home.dart';
import './providers/app_state.dart';

void main() {
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
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'Habit Hub',
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}