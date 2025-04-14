import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  // Métodos de autenticación
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
}
