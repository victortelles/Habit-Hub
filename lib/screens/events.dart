import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../widgets/nav_bar.dart';
import '../providers/app_state.dart';

import 'package:habit_hub/screens/profile.dart';
import 'package:habit_hub/screens/home.dart';
import 'package:habit_hub/screens/community.dart';
import 'package:habit_hub/screens/activity.dart';
import 'package:habit_hub/screens/qr_scanner.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}



class _ExploreScreenState extends State<ExploreScreen> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    var appState = Provider.of<AppState>(context, listen: false);

    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CommunityScreen(),
        ),
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
        title: Text("Explorar"),
        titleTextStyle: TextStyle(
          color: appState.isDarkMode ? Colors.white : Colors.black,
          fontSize: 20,
        ),
        backgroundColor: appState.isDarkMode ? Colors.black : Colors.grey[200],
        iconTheme: IconThemeData(
          color: appState.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QrScanner()),
            );
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue.shade900,
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            textStyle: TextStyle(fontSize: 18),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.camera_alt, size: 24),
              SizedBox(width: 8),
              Text("Escanear QR"),
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
}
