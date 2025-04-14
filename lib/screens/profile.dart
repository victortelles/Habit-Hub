import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_hub/screens/login_options.dart';
import '../widgets/nav_bar.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import 'package:habit_hub/screens/activity.dart';
import 'package:habit_hub/screens/home.dart';
import 'package:habit_hub/screens/community.dart';
import 'package:habit_hub/widgets/profile_personalization.dart';

import 'package:habit_hub/screens/habits_detail.dart';
import 'package:habit_hub/screens/days_detail.dart';
import 'package:habit_hub/screens/exercises_detail.dart';

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
          title: Text('Funcionalidad pendiente'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
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
    final user = FirebaseAuth.instance.currentUser;
    var appState = Provider.of<AppState>(context);

    //Titulo Superior
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

      //Body
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Sección 1: Perfil
            //Circulo para avatar
            Center(
                child: CircleAvatar(
              radius: 50,
              backgroundImage:
                  user?.photoURL != null ? NetworkImage(user!.photoURL!) : null,
              child:
                  user?.photoURL == null ? Icon(Icons.person, size: 50) : null,
            )),

            // Apartado del nombre
            SizedBox(height: 16),
            Center(
                child: Text(
              user?.displayName ?? 'Nombre no disponible',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: appState.isDarkMode ? Colors.white : Colors.black,
              ),
            )),

            //Apartado del correo
            SizedBox(height: 8),
            Center(
                child: Text(
              user?.email ?? 'Correo no disponible',
              style: TextStyle(
                fontSize: 16,
                color: appState.isDarkMode ? Colors.white70 : Colors.black54,
              ),
            )),

//            SizedBox(height: 30),
            SizedBox(height: 16),

            //Sección 2: Personalización
            Text("Personalización",
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            SizedBox(
              height: 300,
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1,
                physics: const BouncingScrollPhysics(),
                children: [

                  // Card de Habitos
                  MiniCard(
                    title: "Tus Hábitos",
                    icon: Icons.self_improvement,
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => HabitsDetail()));
                    },
                  ),

                  // Card de Ejercicios
                  MiniCard(
                    title: "Tus Ejercicios",
                    icon: Icons.fitness_center,
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => ExercisesDetail()));
                    },
                  ),

                  // Card de Dias
                  MiniCard(
                    title: "Tus Días",
                    icon: Icons.calendar_today,
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => DaysDetail()));
                    },
                  ),
                ],
              ),
            ),

            Spacer(),

            //Sección 3: Opciones
            ListTile(
              leading: Icon(Icons.settings,
                  color: appState.isDarkMode ? Colors.white : Colors.black),
              title: Text("Configuración",
                  style: TextStyle(
                      color:
                          appState.isDarkMode ? Colors.white : Colors.black)),
              trailing: Icon(Icons.arrow_forward_ios,
                  color: appState.isDarkMode ? Colors.white70 : Colors.black54),
              onTap: () => _showAlert("Puchurraste en configuración"),
            ),
            Divider(
                color: appState.isDarkMode ? Colors.white24 : Colors.black12),

            // Botón cerrar sesión
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.red),
              title: Text("Cerrar sesión", style: TextStyle(color: Colors.red)),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('Confirmar cierre de sesión'),
                    content: Text('¿Estás seguro de que deseas cerrar sesión?'),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancelar')),
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          await FirebaseAuth.instance.signOut();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => LoginOptions()),
                            (_) => false,
                          );
                        },
                        child: Text('Cerrar sesión',
                            style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );
              },
            ),

            // Botón eliminar cuenta
            ListTile(
              leading: Icon(Icons.delete_forever, color: Colors.red),
              title: Text("Eliminar cuenta", style: TextStyle(color: Colors.red)),
              onTap: () {
                TextEditingController confirmationController = TextEditingController();

                //Mostrar mensaje de confirmacion
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('Eliminar cuenta'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Escribe 'estoy de acuerdo' para confirmar."),
                        TextField(controller: confirmationController),
                      ],
                    ),
                    //Acciones
                    actions: [

                      //Cancelar
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("Cancelar")),

                      //Aceptar
                      TextButton(
                        onPressed: () async {
                          //Texto de confirmacion
                          if (confirmationController.text.trim().toLowerCase() =="estoy de acuerdo") {
                            try {
                              //Funcionalidad de eliminar usuario
                              await Provider.of<AppState>(context, listen: false).deleteUserAccount();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (_) => LoginOptions()),  //redirecciona a login
                                (_) => false,
                              );
                            } catch (error) {
                              Navigator.pop(context); //Cerrar dialogo
                              _showAlert("Error al eliminar cuenta: ${error.toString()}");
                            }
                          } else {
                            _showAlert("Debes escribir exactamente: estoy de acuerdo");
                          }
                        },
                        child: Text("Eliminar",style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );
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
