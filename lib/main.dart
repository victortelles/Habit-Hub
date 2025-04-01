import 'package:flutter/material.dart';
import 'package:habit_hub/firebase_options.dart';
import 'package:habit_hub/screens/login_options.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
//import './screens/home.dart';
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
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'Habit Hub',
        debugShowCheckedModeBanner: false,
        home: LoginOptions(),
      ),
    );
  }
}