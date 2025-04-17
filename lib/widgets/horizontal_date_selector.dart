import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../providers/app_state.dart';

class HorizontalDateSelector extends StatelessWidget {
  final AppState appState;

  const HorizontalDateSelector({super.key, required this.appState});

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    DateTime firstDayOfWeek = today.subtract(Duration(days: today.weekday - 1));

    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 30, // mostrar un rango de 30 dias (1 mes)
        itemBuilder: (context, index) {
          DateTime date = firstDayOfWeek
              .add(Duration(days: index)); // Mostrar el dia actual en el centro
          bool isToday = date.year == today.year &&
              date.month == today.month &&
              date.day == today.day;

          return Container(
            width: 50,
            margin: EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: isToday
                  ? Colors.blue.shade900
                  : (appState.isDarkMode ? Colors.grey.shade800 : Colors.white),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat('E').format(date),
                  style: TextStyle(
                      color: isToday
                          ? Colors.white
                          : (appState.isDarkMode
                              ? Colors.white
                              : Colors.black)),
                ),
                Text(
                  "${date.day}",
                  style: TextStyle(
                      color: isToday
                          ? Colors.white
                          : (appState.isDarkMode
                              ? Colors.white
                              : Colors.black)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
