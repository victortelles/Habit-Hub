import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, bool> habitStatus = {
    "Tu agua del día": false,
    "Meditación": false,
    "Regar tus plantas": false,
    "Lectura diaria": false,
    "Tender la cama": false,
    "Pasear al perro": false
  };

  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        backgroundColor: isDarkMode ? Colors.black : Colors.grey[200],
        appBar: AppBar(
          title: Text("Habit Hub"),
          actions: [
            IconButton(
              icon: Icon(isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
              onPressed: () {
                setState(() {
                  isDarkMode = !isDarkMode;
                });
              },
            )
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                SizedBox(height: 16),
                _buildDateSelector(),
                SizedBox(height: 16),
                _buildProgressCard(context),
                SizedBox(height: 16),
                _buildChallenges(context),
                SizedBox(height: 16),
                _buildHabitsList(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hola, Usuario 👋",
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text("Listo para empezar tu día",
                style: GoogleFonts.poppins(color: Colors.grey)),
          ],
        ),
        Icon(Icons.emoji_emotions_outlined, color: Colors.blue.shade900, size: 30),
      ],
    );
  }

  Widget _buildDateSelector() {
    DateTime today = DateTime.now();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (index) {
        DateTime date = today.add(Duration(days: index));
        return Column(
          children: [
            Text(DateFormat('E').format(date)),
            CircleAvatar(
              radius: 16,
              backgroundColor: index == 0 ? Colors.blue.shade900 : Colors.white,
              child: Text(
                "${date.day}",
                style: TextStyle(color: index == 0 ? Colors.white : Colors.black),
              ),
            )
          ],
        );
      }),
    );
  }

  Widget _buildProgressCard(BuildContext context) {
    int completedHabits = habitStatus.values.where((status) => status).length;
    int totalHabits = habitStatus.length;
    double progress = totalHabits > 0 ? completedHabits / totalHabits : 0;
    Color cardColor = progress == 1.0 ? Colors.green : Colors.blue.shade900;

    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Progreso de hábitos",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4),
            Text("$completedHabits de $totalHabits completados",
                style: GoogleFonts.poppins(color: Colors.white)),
            SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white.withOpacity(0.5),
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChallenges(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Desafío presionado");
      },
      child: Card(
        color: Colors.blue.shade900,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          title: Text("Comunidad 👥", style: TextStyle(color: Colors.white)),
          subtitle: Text("Entérate de los hábitos de tus amigos", style: TextStyle(color: Colors.white70)),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildHabitsList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Tus hábitos", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
        ...habitStatus.keys.map((habit) => GestureDetector(
              onTap: () {
                setState(() {
                  habitStatus[habit] = !habitStatus[habit]!;
                });
              },
              child: Card(
                child: ListTile(
                  title: Text(habit),
                  leading: Icon(
                    Icons.check_circle,
                    color: habitStatus[habit]! ? Colors.blue.shade900 : Colors.grey,
                  ),
                ),
              ),
            )),
      ],
    );
  }
}