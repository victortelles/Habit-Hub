import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import '../widgets/nav_bar.dart';
import '../providers/app_state.dart';

import '../widgets/home_header.dart';
import '../widgets/horizontal_date_selector.dart';
import '../widgets/habits_progress_card.dart';
import '../widgets/community_card.dart';
import '../widgets/habits_list.dart';

import 'package:habit_hub/screens/profile.dart';
import 'package:habit_hub/screens/activity.dart';
import 'package:habit_hub/screens/community.dart';

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
    } else if (index == 2) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Pantalla pendiente'),
            content: Text('Puchurraste explorar'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ActivityScreen(),
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
        titleTextStyle: TextStyle(
            color: appState.isDarkMode ? Colors.white : Colors.black,
            fontSize: 20),
        backgroundColor: appState.isDarkMode ? Colors.black : Colors.grey[200],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Widget de HomeHeader
              HomeHeader(appState: appState),
              //_buildHeader(appState),
              SizedBox(height: 16),
              //Widget de HorizontalDate
              HorizontalDateSelector(appState: appState),
              //_buildDateSelector(appState),
              SizedBox(height: 16),
              //Widget de HabitProgressCard
              HabitsProgressCard(appState: appState),
              //_buildProgressCard(appState),
              SizedBox(height: 16),
              //Widget de Community
              CommunityCard(),
              //_buildCommunity(appState),
              SizedBox(height: 16),
              Text("Tus hábitos",
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color:
                          appState.isDarkMode ? Colors.white : Colors.black)),
              Expanded(
                //Widget de HabitList
                child: HabitsList(appState: appState)),
              //Expanded(child: _buildHabitsList(appState)),
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

//  Widget _buildHeader(AppState appState) {
//    //Obtener nombre y limitarlo
//    final name = appState.userProfile?.name ?? 'Usuario';
//    final nameParts = name.split(' ');
//    String displayName = 'Usuario';
//
//    //Separar el nombre y solo tomar [NombreP] [NombreSec]
//    if (nameParts == 1) {
//      displayName = nameParts[0];
//    } else {
//      displayName = '${nameParts[0]} ${nameParts[1].substring(0, 1)}.';
//    }
//
//    final greeting = 'Hola, $displayName';
//    double rotationAngle = 0;
//
//    return Row(
//      mainAxisAlignment: MainAxisAlignment.start,
//      children: [
//        // Animated Waving Hand Icon
//        TweenAnimationBuilder<double>(
//          tween: Tween<double>(begin: -10, end: 10),
//          duration: const Duration(milliseconds: 300),
//          builder: (context, value, child) {
//            rotationAngle = value;
//            return Transform.rotate(
//              angle: value * (3.141592653589793 / 180),
//              child: Icon(Icons.waving_hand,
//                  color: Colors.blue.shade900, size: 30),
//            );
//          },
//        ),
//        const SizedBox(width: 8), // Espacio entre el icono y el texto
//
//        Expanded(
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: [
//              Text(
//                greeting,
//                style: GoogleFonts.poppins(
//                  fontSize: 22,
//                  fontWeight: FontWeight.bold,
//                  color: appState.isDarkMode ? Colors.white : Colors.black,
//                ),
//                overflow: TextOverflow.ellipsis,
//              ),
//              Text("Listo para empezar tu día",
//                  style: GoogleFonts.poppins(color: Colors.grey)),
//            ],
//          ),
//        ),
//      ],
//    );
//  }
//
//  Widget _buildDateSelector(AppState appState) {
//    DateTime today = DateTime.now();
//    DateTime firstDayOfWeek = today.subtract(Duration(days: today.weekday - 1));
//
//    return SizedBox(
//      height: 60,
//      child: ListView.builder(
//        scrollDirection: Axis.horizontal,
//        itemCount: 30, // mostrar un rango de 30 dias (1 mes)
//        itemBuilder: (context, index) {
//          DateTime date = firstDayOfWeek
//              .add(Duration(days: index)); // Mostrar el dia actual en el centro
//          bool isToday = date.year == today.year &&
//              date.month == today.month &&
//              date.day == today.day;
//
//          return Container(
//            width: 50,
//            margin: EdgeInsets.symmetric(horizontal: 4),
//            decoration: BoxDecoration(
//              color: isToday
//                  ? Colors.blue.shade900
//                  : (appState.isDarkMode ? Colors.grey.shade800 : Colors.white),
//              borderRadius: BorderRadius.circular(8),
//            ),
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: [
//                Text(
//                  DateFormat('E').format(date),
//                  style: TextStyle(
//                      color: isToday
//                          ? Colors.white
//                          : (appState.isDarkMode
//                              ? Colors.white
//                              : Colors.black)),
//                ),
//                Text(
//                  "${date.day}",
//                  style: TextStyle(
//                      color: isToday
//                          ? Colors.white
//                          : (appState.isDarkMode
//                              ? Colors.white
//                              : Colors.black)),
//                ),
//              ],
//            ),
//          );
//        },
//      ),
//    );
//  }
//
//  Widget _buildProgressCard(AppState appState) {
//    int completedHabits =
//        appState.habitStatus.values.where((status) => status).length;
//    int totalHabits = appState.habitStatus.length;
//    double progress = totalHabits > 0 ? completedHabits / totalHabits : 0;
//    Color cardColor = progress == 1.0 ? Colors.green : Colors.blue.shade900;
//
//    return Card(
//      color: cardColor,
//      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//      child: Padding(
//        padding: const EdgeInsets.all(16.0),
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: [
//            Text(
//              "Progreso de hábitos",
//              style: GoogleFonts.poppins(
//                fontSize: 16,
//                fontWeight: FontWeight.bold,
//                color: Colors.white,
//              ),
//            ),
//            SizedBox(height: 4),
//            Text("$completedHabits de $totalHabits completados",
//                style: GoogleFonts.poppins(color: Colors.white)),
//            SizedBox(height: 8),
//            LinearProgressIndicator(
//              value: progress,
//              backgroundColor: Colors.white.withOpacity(0.5),
//              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//
//  Widget _buildCommunity(AppState appState) {
//    return GestureDetector(
//      onTap: () {
//        Navigator.push(
//          context,
//          MaterialPageRoute(
//            builder: (context) => CommunityScreen(),
//          ),
//        );
//      },
//      child: Card(
//        color: Colors.blue.shade900,
//        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//        child: ListTile(
//          title: Text("Comunidad 👥", style: TextStyle(color: Colors.white)),
//          subtitle: Text("Entérate de los hábitos de tus amigos",
//              style: TextStyle(color: Colors.white70)),
//          trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
//        ),
//      ),
//    );
//  }
//
//  Widget _buildHabitsList(AppState appState) {
//    return ListView(
//      children: appState.habitStatus.keys
//          .map((habit) => GestureDetector(
//                onTap: () {
//                  appState.updateHabit(habit, !appState.habitStatus[habit]!);
//                },
//                child: Card(
//                  color: appState.isDarkMode
//                      ? Colors.grey.shade800
//                      : Colors.grey.shade300,
//                  child: ListTile(
//                    title: Text(habit),
//                    textColor:
//                        appState.isDarkMode ? Colors.white : Colors.black,
//                    leading: Icon(
//                      Icons.check_circle,
//                      color: appState.habitStatus[habit]!
//                          ? Colors.blue.shade900
//                          : Colors.grey,
//                    ),
//                  ),
//                ),
//              ))
//          .toList(),
//    );
//  }
}
