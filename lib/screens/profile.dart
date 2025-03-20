import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/nav_bar.dart';
import './home.dart';
import './community.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 4;

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
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Funcionalidad pendiente"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text("Cerrar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);

    return Scaffold(
      backgroundColor: appState.isDarkMode ? Colors.black : Colors.grey[200],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Mi Perfil"),
        titleTextStyle: TextStyle(
          color: appState.isDarkMode ? Colors.white : Colors.black,
          fontSize: 20,
        ),
        backgroundColor: appState.isDarkMode ? Colors.grey[900] : Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(radius: 50),
            SizedBox(height: 16),
            Text(
              "Nombre de Usuario",
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: appState.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "correo@ejemplo.com",
              style: TextStyle(
                fontSize: 16,
                color: appState.isDarkMode ? Colors.white70 : Colors.black54,
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.settings, color: appState.isDarkMode ? Colors.white : Colors.black),
              title: Text("Configuración",
                  style: TextStyle(color: appState.isDarkMode ? Colors.white : Colors.black)),
              trailing: Icon(Icons.arrow_forward_ios, color: appState.isDarkMode ? Colors.white70 : Colors.black54),
              onTap: () {
                _showAlert("Puchurraste en configuración");
              },
            ),
            Divider(color: appState.isDarkMode ? Colors.white24 : Colors.black12),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.red),
              title: Text("Cerrar sesión", style: TextStyle(color: Colors.red)),
              onTap: () {
                _showAlert("Puchurraste en cerrar sesión");
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
