import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
//Provider
import '../providers/app_state.dart';
import 'package:provider/provider.dart';
//Servicios
import 'package:firebase_auth/firebase_auth.dart';
import 'package:habit_hub/services/firebase.dart';
import '../services/firestore.dart';
//Modelos
import '../models/user.dart';
//Widgets
import 'package:habit_hub/widgets/animated_logo.dart';
//Ventanas
import 'package:habit_hub/screens/login.dart';
import 'package:habit_hub/screens/register.dart';


class LoginOptions extends StatefulWidget {
  const LoginOptions({super.key});

  @override
  State<LoginOptions> createState() => _LoginOptionsState();
}

class _LoginOptionsState extends State<LoginOptions> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirestoreService _firestoreService = FirestoreService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Verificar si ya hay un usuario autenticado
    _checkCurrentUser();
  }

  void _checkCurrentUser() async {
    User? user = _auth.currentUser;
    if (user != null) {
      // Si hay un usuario autenticado, verificar si existe en Firestore
      final userExists = await _firestoreService.getUserById(user.uid);
      if (userExists != null) {
        // Si existe en Firestore, navegar a la pantalla principal
        Navigator.of(context).pushReplacementNamed('/home');
      }
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Iniciar el proceso de inicio de sesión con Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // El usuario canceló el inicio de sesión
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // Obtener detalles de autenticación de la solicitud
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Crear una nueva credencial
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Una vez que tenemos la credencial, podemos iniciar sesión con Firebase
      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        // Verificar si el usuario ya existe en Firestore
        final existingUser = await _firestoreService.getUserById(user.uid);

        if (existingUser == null) {
          // Si no existe, crear un nuevo registro en Firestore
          final newUser = UserModel(
            uid: user.uid,
            email: user.email ?? '',
            name: user.displayName ?? 'Usuario',
            profilePic: user.photoURL,
            createdAt: DateTime.now(),
          );

          await Provider.of<AppState>(context, listen: false)
              .saveUserToFirestore(newUser);

          // Navegar al flujo de personalización
          Navigator.of(context).pushReplacementNamed('/gender_selection');
        } else {
          // Si ya existe, ir directamente a la pantalla principal
          Navigator.of(context).pushReplacementNamed('/home');
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text("Error al iniciar sesión con Google: ${e.toString()}")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _goToEmailLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Register()),
    );
  }

  void _goToLoginScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.white))
          : Builder(builder: (context) {
              return Center(
                child: Column(
                  children: [

                    //Logo animado
                    const AnimatedLogo(
                      imagePath: 'assets/images/splash/logo.png',
                      size: 350,
                    ),

                    //Espaciado
                    SizedBox(height: 50),

                    //Contenido
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25.0, 0, 0, 0),
                          child: Text("Es tu momento.",
                              style: GoogleFonts.archivo(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold))),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25.8, 0, 0, 0),
                        ),
                        Text(
                            "Encuentra amigos y comparte tus metas con\n ellos",
                            style: GoogleFonts.archivo(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 15)))
                      ],
                    ),
                    SizedBox(height: 50),
                    // Botón para iniciar sesión con email
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 8, 20.0, 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed:
                                  _goToLoginScreen, // Usar la nueva pantalla de login
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:
                                        Icon(Icons.email, color: Colors.black),
                                  ),
                                  Text(
                                    "Iniciar Sesion",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ))
                        ],
                      ),
                    ),
                    // Botón para registrarse con email
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: SizedBox(
                            height: 50,
                            child: TextButton(
                              onPressed: _goToEmailLogin,
                              child: Text(
                                "¿No tienes cuenta? Regístrate",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ))
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    // Botones de redes sociales
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
//Boton para iniciar con Apple
//                          SocialButton(
//                            icon: "apple",
//                            onPressed: () {
//                              ScaffoldMessenger.of(context).showSnackBar(
//                                SnackBar(
//                                  duration: Duration(seconds: 2),
//                                  content: Text("Inicio con Apple ID (por implementar)"),
//                                )
//                              );
//                            },
//                          ),
                        SocialButton(
                          icon: "google",
                          onPressed: _signInWithGoogle,
                        ),
//Boton para iniciar sesion con facbook
//                          SocialButton(
//                            icon: "facebook",
//                            onPressed: () {
//                              ScaffoldMessenger.of(context).showSnackBar(
//                                SnackBar(
//                                  duration: Duration(seconds: 2),
//                                  content: Text("Inicio con Facebook (por implementar)"),
//                                )
//                              );
//                            },
//                          ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Al continuar aceptas nuestros términos de uso y política de privacidad",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    )
                  ],
                ),
              );
            }),
    );
  }
}

// Widget para los botones de redes sociales
class SocialButton extends StatelessWidget {
  final String icon;
  final VoidCallback onPressed;

  const SocialButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData iconData;

    switch (icon) {
//      case "apple":
//        iconData = Icons.apple;
//        break;
      case "google":
        iconData = Icons.g_mobiledata;
        break;
      case "facebook":
      //       iconData = Icons.facebook;
      //       break;
      default:
        iconData = Icons.login;
    }

    return SizedBox(
      width: 60,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: CircleBorder(),
          padding: EdgeInsets.all(12),
        ),
        child: Icon(iconData, color: Colors.blueAccent, size: 30),
      ),
    );
  }
}
