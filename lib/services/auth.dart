import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:habit_hub/models/user.dart';
import 'package:habit_hub/services/firebase.dart';
import 'package:habit_hub/services/firestore.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirestoreService _firestoreService = FirestoreService();

  // Verifica si el usuario ya está autenticado y navega en consecuencia
  Future<void> checkCurrentUser(BuildContext context) async {
    User? user = _auth.currentUser;
    if (user != null) {
      final userExists = await _firestoreService.getUserById(user.uid);
      if (userExists != null) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    }
  }

  // Autenticación con Google
  Future<void> signInWithGoogle(BuildContext context, Function(bool) onLoading) async {
    onLoading(true);
    try {
      // Forzar a seleccionar cuenta
      await _googleSignIn.signOut();

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        onLoading(false);
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        final existingUser = await _firestoreService.getUserById(user.uid);

        if (existingUser == null) {
          final newUser = UserModel(
            uid: user.uid,
            email: user.email ?? '',
            name: user.displayName ?? 'Usuario',
            profilePic: user.photoURL,
            createdAt: DateTime.now(),
          );

          await Provider.of<AppState>(context, listen: false).saveUserToFirestore(newUser);
          Navigator.of(context).pushReplacementNamed('/gender_selection');
        } else {
          Navigator.of(context).pushReplacementNamed('/home');
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al iniciar sesión con Google: ${e.toString()}")),
      );
    } finally {
      onLoading(false);
    }
  }
}
