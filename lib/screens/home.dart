import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'community.dart';
import 'profile.dart';
import '../widgets/nav_bar.dart';
import '../providers/app_state.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    var appState = Provider.of<AppState>(context, listen: false);

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CommunityScreen(),
        ),
      );
    } else if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileScreen(),
        ),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);

    return Scaffold(
      backgroundColor: appState.isDarkMode ? Colors.black : Colors.grey[200],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Habit Hub"),
        titleTextStyle: TextStyle(color: appState.isDarkMode ? Colors.white : Colors.black, fontSize: 20),
        actions: [
          IconButton(
            icon: Icon(appState.isDarkMode ? Icons.wb_sunny: Icons.nightlight_round, color: Colors.blue.shade900),
            onPressed: () {
              appState.toggleDarkMode();
            },
          )
        ],
        backgroundColor: appState.isDarkMode ? Colors.black : Colors.grey[200],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(appState),
              SizedBox(height: 16),
              _buildDateSelector(appState),
              SizedBox(height: 16),
              _buildProgressCard(appState),
              SizedBox(height: 16),
              _buildCommunity(appState),
              SizedBox(height: 16),
              Text("Tus hábitos", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: appState.isDarkMode ? Colors.white : Colors.black)),
              Expanded(child: _buildHabitsList(appState)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _buildHeader(AppState appState) {
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
                color: appState.isDarkMode ? Colors.white : Colors.black,
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

  Widget _buildDateSelector(AppState appState) {
    DateTime today = DateTime.now();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (index) {
        DateTime date = today.subtract(Duration(days: today.weekday - 1)).add(Duration(days: index));
        return Column(
          children: [
            Text(DateFormat('E').format(date), style: TextStyle(color: appState.isDarkMode ? Colors.white : Colors.black)),
            CircleAvatar(
              radius: 16,
              backgroundColor: index == today.weekday - 1 ? Colors.blue.shade900 : Colors.white,
              child: Text(
                "${date.day}",
                style: TextStyle(color: index == today.weekday - 1 ? Colors.white : Colors.black),
              ),
            )
          ],
        );
      }),
    );
  }

  Widget _buildProgressCard(AppState appState) {
    int completedHabits = appState.habitStatus.values.where((status) => status).length;
    int totalHabits = appState.habitStatus.length;
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

  Widget _buildCommunity(AppState appState) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CommunityScreen(),
          ),
        );
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

  Widget _buildHabitsList(AppState appState) {
    return ListView(
      children: appState.habitStatus.keys.map((habit) => GestureDetector(
        onTap: () {
          appState.updateHabit(habit, !appState.habitStatus[habit]!);
        },
        child: Card(
          color: appState.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
          child: ListTile(
            title: Text(habit),
            textColor: appState.isDarkMode ? Colors.white : Colors.black,
            leading: Icon(
              Icons.check_circle,
              color: appState.habitStatus[habit]! ? Colors.blue.shade900 : Colors.grey,
            ),
          ),
        ),
      )).toList(),
    );
  }
}
