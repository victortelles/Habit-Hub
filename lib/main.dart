import 'package:flutter/material.dart';
import 'package:habit_hub/models/user_preferences.dart';
import 'screens/gender_selection.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Hub',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Habit Hub'),
          backgroundColor: Colors.blueAccent,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold
          ),
        ),
        body: GenderSelection(
          userPreferences: UserPreferences(),
        ),
      ),
    );
  }
}