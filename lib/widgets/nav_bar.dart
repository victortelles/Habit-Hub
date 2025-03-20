import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  BottomNavBar({required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Inicio",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.group),
          label: "Comunidad",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: "Explorar",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.emoji_events),
          label: "Actividad",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Mi perfil",
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.blue.shade900,
      unselectedItemColor: Colors.grey,
      onTap: onItemTapped,
    );
  }
}
