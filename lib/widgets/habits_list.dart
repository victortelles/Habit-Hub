import 'package:flutter/material.dart';
import '../../providers/app_state.dart';

class HabitsList extends StatelessWidget {
  final AppState appState;

  const HabitsList({super.key, required this.appState});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: appState.habitStatus.keys
          .map((habit) => GestureDetector(
                onTap: () {
                  appState.updateHabit(habit, !appState.habitStatus[habit]!);
                },
                child: Card(
                  color: appState.isDarkMode
                      ? Colors.grey.shade800
                      : Colors.grey.shade300,
                  child: ListTile(
                    title: Text(habit),
                    textColor:
                        appState.isDarkMode ? Colors.white : Colors.black,
                    leading: Icon(
                      Icons.check_circle,
                      color: appState.habitStatus[habit]!
                          ? Colors.blue.shade900
                          : Colors.grey,
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
