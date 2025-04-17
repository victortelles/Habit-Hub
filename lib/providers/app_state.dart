import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_preferences.dart';
import '../models/user.dart';
import '../services/firebase.dart';

class AppState with ChangeNotifier {
  bool _isDarkMode = false;
  Map<String, bool> _habitStatus = {
    'Pasear al perro': false,
    'Regar las plantas': false,
    'Tender la cama': false,
    'Ir al gym': false,
    'Lectura diaria': false,
  };

  // Autenticación y Firestore
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  // Estado de autenticación
  User? _currentUser;
  UserModel? _userProfile;
  bool _isLoading = false;

  AppState() {
    _init();
  }

  void _init() {
    // Escuchar cambios en la autenticación
    _auth.authStateChanges().listen((User? user) {
      _currentUser = user;
      if (user != null) {
        _loadUserProfile();
      } else {
        _userProfile = null;
      }
      notifyListeners();
    });
  }

  // Cargar perfil de usuario de Firestore
  Future<void> _loadUserProfile() async {
    if (_currentUser == null) return;

    setLoading(true);
    try {
      _userProfile = await _firestoreService.getUserById(_currentUser!.uid);
      notifyListeners();
    } catch (e) {
      print('Error loading user profile: $e');
    } finally {
      setLoading(false);
    }
  }

  // Gestores de Estado
  bool get isDarkMode => _isDarkMode;
  Map<String, bool> get habitStatus => _habitStatus;
  User? get currentUser => _currentUser;
  UserModel? get userProfile => _userProfile;
  bool get isLoading => _isLoading;

  // Métodos para actualizar el estado
  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void updateHabit(String habit, bool status) {
    _habitStatus[habit] = status;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Métodos de autenticación (Cerrar sesion)
  Future<void> signOut() async {
    await _auth.signOut();
    _userProfile = null;
    notifyListeners();
  }

  // Método para guardar un usuario nuevo en Firestore
  Future<void> saveUserToFirestore(UserModel user) async {
    try {
      await _firestoreService.createUser(user);
      _userProfile = user;
      notifyListeners();
    } catch (e) {
      print('Error saving user to Firestore: $e');
      throw e;
    }
  }

  // Método para actualizar las preferencias del usuario
  Future<void> updateUserPreferences({
    String? gender,
    List<String>? habits,
    List<String>? sports,
    List<String>? exerciseTypes,
    List<String>? trainingDays,
  }) async {
    if (_currentUser == null) return;

    setLoading(true);
    try {
      await _firestoreService.saveUserPreferences(
        uid: _currentUser!.uid,
        gender: gender,
        habits: habits,
        sports: sports,
        exerciseTypes: exerciseTypes,
        trainingDays: trainingDays,
      );

      // Recargar el perfil para reflejar los cambios
      await _loadUserProfile();
    } catch (e) {
      print('Error updating user preferences: $e');
      throw e;
    } finally {
      setLoading(false);
    }
  }

  //Metodo para elimianr cuenta
  Future<void> deleteUserAccount() async {
    if (_currentUser == null) throw Exception("No hay usuario autenticado.");

    setLoading(true);

    try {
      //Eliminar usuario en DB (Firestore)
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_currentUser!.uid)
          .delete();

      //Eliminar cuenta en Auth (Firebase)
      await _currentUser!.delete();

      //Limpiar estado
      _userProfile = null;
      _currentUser = null;

      notifyListeners();
    } catch (error) {
      throw Exception("Error al eliminar la cuenta ${error.toString()}");
    } finally {
      setLoading(false);
    }
  }

  //Metodo para Obtener Habitos
  Future<List<String>> getUserHabits() async {
    if (_currentUser == null) return [];

    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(_currentUser!.uid)
          .get();

      if (userDoc.exists && userDoc.data() != null) {
        Map<String, dynamic>? data = userDoc.data() as Map<String, dynamic>?;
        return (data?['habits'] as List<dynamic>?)?.cast<String>() ?? [];
      }
      return [];
    } catch (e) {
      print("Error obteniendo los habitos del usuario: $e");
      return [];
    }
  }

  //Metodo para Obtener todas las preferencias del usuario
  Future<UserPreferences> getUserPreferences() async {
    if (_currentUser == null) return UserPreferences();

    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(_currentUser!.uid)
          .get();

      if (userDoc.exists && userDoc.data() != null) {
        Map<String, dynamic>? data = userDoc.data() as Map<String, dynamic>?;
        return UserPreferences(
          gender: data?['gender'] as String?,
          selectedHabits:
              (data?['habits'] as List<dynamic>?)?.cast<String>() ?? [],
          selectedSports:
              (data?['sports'] as List<dynamic>?)?.cast<String>() ?? [],
          selectedExercises:
              (data?['excersice_types'] as List<dynamic>?)?.cast<String>() ??
                  [],
          selectedDays:
              (data?['training_days'] as List<dynamic>?)?.cast<String>() ?? [],
        );
      }
      return UserPreferences(); //Retorna una instancia por defecto si no existe
    } catch (e) {
      print("Error al obtener las preferencias del usuario: $e");
      return UserPreferences(); //Retorna una instancia por defecto en caso de error
    }
  }

// Método para actualizar la imagen de perfil del usuario
  Future<void> updateProfileImage(String imageUrl) async {
    if (_currentUser == null || _userProfile == null) return;

    setLoading(true);
    try {
      // 1. Actualizar el modelo de usuario localmente
      final updatedUser = _userProfile!.copyWith(profilePic: imageUrl);
      _userProfile = updatedUser;

      // 2. Guardar la actualización en Firestore
      await _firestoreService.updateUserProfile(updatedUser);

      notifyListeners();
    } catch (e) {
      print('Error updating profile image: $e');
      // Considera mostrar un mensaje de error al usuario
    } finally {
      setLoading(false);
    }
  }
}
