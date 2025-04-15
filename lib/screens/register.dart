import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_hub/models/user_preferences.dart';
//import 'package:habit_hub/models/user.dart';
import 'package:habit_hub/screens/gender_selection.dart';
import 'package:habit_hub/services/auth.dart';
//import 'package:provider/provider.dart';
//import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
//import 'package:firebase_ui_auth/firebase_ui_auth.dart';
//import '../providers/app_state.dart';
import 'package:habit_hub/widgets/register_forms.dart';
import 'package:intl/intl.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
//  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  DateTime? _selectedDate;
  bool _isLoading = false;

  //Funcionalidad de seleccionar fecha
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          _selectedDate ?? DateTime.now().subtract(Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dobController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  //Funcionalidad para registrar al usuario.
  Future<void> _register() async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor completa todos los campos")),
      );
      return;
    }

    //Validacion de edad minima
    final currentDate = DateTime.now();
    final minAge = 16;
    final age = currentDate.year - _selectedDate!.year;
    //validacion
    final isOldEnough = (age > minAge) ||
        (age == minAge &&
            (currentDate.month > _selectedDate!.month ||
                (currentDate.month == _selectedDate!.month &&
                    currentDate.day >= _selectedDate!.day)));
    if (!isOldEnough) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Debes tener al menos 16 años para registrarte")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    //Inicializar el AuthService
    final authService = AuthService();

    final errorMessage = await authService.registerWithEmail(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      birthdate: _selectedDate!,
      context: context
    );

    setState(() {
      _isLoading = false;
    });

    if (errorMessage != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));
      return;
    }

    //Navegacion tras el registro exitoso
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => GenderSelection(userPreferences: UserPreferences())));

//    try {
//      // Registrar usuario en Firebase Auth
//      UserCredential userCredential =
//          await _auth.createUserWithEmailAndPassword(
//        email: _emailController.text.trim(),
//        password: _passwordController.text.trim(),
//      );
//
//      // Actualizar nombre de usuario en Auth
//      await userCredential.user?.updateDisplayName(_nameController.text.trim());
//
//      // Crear modelo de usuario para Firestore
//      UserModel newUser = UserModel(
//        uid: userCredential.user!.uid,
//        email: _emailController.text.trim(),
//        name: _nameController.text.trim(),
//        birthdate: _selectedDate,
//        createdAt: DateTime.now(),
//      );
//
//      // Guardar usuario en Firestore usando el AppState
//      await Provider.of<AppState>(context, listen: false)
//          .saveUserToFirestore(newUser);
//
//      // Navegar a la siguiente pantalla de personalización
//      Navigator.of(context).push(
//        MaterialPageRoute(
//          builder: (context) => GenderSelection(
//            userPreferences: UserPreferences(),
//          ),
//        ),
//      );
//    } catch (e) {
//      String errorMessage = "Error al registrar";
//      if (e is FirebaseAuthException) {
//        switch (e.code) {
//          case 'email-already-in-use':
//            errorMessage = "El correo ya está en uso";
//            break;
//          case 'invalid-email':
//            errorMessage = "El formato de correo electrónico no es válido";
//            break;
//          case 'weak-password':
//            errorMessage = "La contraseña es muy débil";
//            break;
//          default:
//            errorMessage = "Error: ${e.message}";
//        }
//      }
//
//      ScaffoldMessenger.of(context).showSnackBar(
//        SnackBar(content: Text(errorMessage)),
//      );
//    } finally {
//      setState(() {
//        _isLoading = false;
//      });
//    }
//  }

//    //Widget Estilo del formulario
//    Widget _buildTextField(
//      String label,
//      TextEditingController controller,
//      IconData icon, {
//      bool obscureText = false,
//      TextInputType keyboardType = TextInputType.text,
//    }) {
//      return Container(
//        decoration: BoxDecoration(
//          color: Colors.white.withOpacity(0.1),
//          borderRadius: BorderRadius.circular(8),
//        ),
//        child: TextField(
//          controller: controller,
//          obscureText: obscureText,
//          keyboardType: keyboardType,
//          style: TextStyle(color: Colors.white),
//          decoration: InputDecoration(
//            labelText: label,
//            labelStyle: TextStyle(color: Colors.white70),
//            prefixIcon: Icon(icon, color: Colors.white70),
//            border: InputBorder.none,
//            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//          ),
//        ),
//      );
//    }
  }

  @override
  //Estructura del formulario
  //Armado de Estructura & Estilos
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Apartado del titulo
            SizedBox(height: 20),
            Text(
              "Crear Cuenta",
              style: GoogleFonts.archivo(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            //Apartado de descripcion
            SizedBox(height: 10),
            Text(
              "Crea una cuenta para comenzar tu viaje fitness",
              style: GoogleFonts.archivo(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),

            //Apartado de formulario
            SizedBox(height: 40),

            //Campo Nombre
            RegisterFormField(
              label: 'Nombre',
              controller: _nameController,
              icon: Icons.person
            ),

            const SizedBox(height: 16),
            //Campo correo electronico
            RegisterFormField(
              label: 'Correo electrónico',
              controller: _emailController,
              icon: Icons.email
            ),

            const SizedBox(height: 16),
            //Campo Contraseña
            RegisterFormField(
              label: 'Contraseña',
              controller: _passwordController,
              icon: Icons.lock,
              obscureText: true
            ),

//              _buildTextField("Nombre", _nameController, Icons.person),
//
//              SizedBox(height: 16),
//              _buildTextField(
//                  "Correo electrónico", _emailController, Icons.email),
//
//              SizedBox(height: 16),
//              _buildTextField("Contraseña", _passwordController, Icons.lock,
//                  obscureText: true),

            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: RegisterFormField(
                    label: 'Fecha de nacimiento',
                    controller: _dobController,
                    icon: Icons.calendar_today),
              ),
            ),

            //Apartado del boton
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _isLoading ? null : _register,
                child: _isLoading
                    ? CircularProgressIndicator()
                    : Text(
                        "Registrarse",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
