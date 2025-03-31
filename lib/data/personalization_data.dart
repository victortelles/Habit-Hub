import 'package:flutter/material.dart';

class PersonalizationData {

  // Genero
  static const List<Map<String, dynamic>> genderOptions = [
    {'name': 'Hombre', 'icon': Icons.male, 'value': 'male'},
    {'name': 'Mujer', 'icon': Icons.female, 'value': 'female'},
  ];

  // Hábitos
  static const List<Map<String, dynamic>> habitOptions = [
    {'name': 'Tomar agua', 'icon': Icons.water_drop, 'value': 'water'},
    {'name': 'Leer', 'icon': Icons.book, 'value': 'read'},
    {'name': 'Meditar', 'icon': Icons.self_improvement, 'value': 'meditation'},
    {'name': 'Estudio', 'icon': Icons.school, 'value': 'study'},
    {'name': 'Escritura', 'icon': Icons.edit, 'value': 'writing'},
    {'name': 'Dibujo', 'icon': Icons.brush, 'value': 'drawing'},
    {'name': 'Dormir', 'icon': Icons.bedtime, 'value': 'sleep'},
  ];

  // Ejercicios
  static const List<Map<String, dynamic>> exerciseOptions = [
    {'name': 'Correr', 'icon': Icons.directions_run, 'value': 'running'},
    {'name': 'Gym', 'icon': Icons.fitness_center, 'value': 'gym'},
    {'name': 'Gimnasia', 'icon': Icons.sports_gymnastics, 'value': 'gymnastics'},
    {'name': 'Cross-fit', 'icon': Icons.timer, 'value': 'crossfit'},
    {'name': 'Yoga', 'icon': Icons.spa, 'value': 'yoga'},
    {'name': 'Natación', 'icon': Icons.pool, 'value': 'swimming'},
    {'name': 'Ciclismo', 'icon': Icons.directions_bike, 'value': 'cycling'},
  ];

  // Deportes
  static const List<Map<String, dynamic>> sportOptions = [
    {'name': 'Basquetbol', 'icon': Icons.sports_basketball, 'value': 'basketball'},
    {'name': 'Soccer', 'icon': Icons.sports_soccer, 'value': 'soccer'},
    {'name': 'Volleyball', 'icon': Icons.sports_volleyball, 'value': 'volleyball'},
    {'name': 'Tenis', 'icon': Icons.sports_tennis, 'value': 'tennis'},
    {'name': 'Béisbol', 'icon': Icons.sports_baseball, 'value': 'baseball'},
    {'name': 'Golf', 'icon': Icons.sports_golf, 'value': 'golf'},
    {'name': 'Hockey', 'icon': Icons.sports_hockey, 'value': 'hockey'},
    {'name': 'Rugby', 'icon': Icons.sports_football, 'value': 'rugby'},
    {'name': 'Ping Pong', 'icon': Icons.table_chart, 'value': 'pingpong'},
    {'name': 'Boxeo', 'icon': Icons.sports_mma, 'value': 'boxing'},
  ];

  // Días
  static const List<Map<String, dynamic>> dayOptions = [
    {'name': 'Lunes', 'icon': Icons.calendar_today, 'value': 'monday'},
    {'name': 'Martes', 'icon': Icons.calendar_today, 'value': 'tuesday'},
    {'name': 'Miércoles', 'icon': Icons.calendar_today, 'value': 'wednesday'},
    {'name': 'Jueves', 'icon': Icons.calendar_today, 'value': 'thursday'},
    {'name': 'Viernes', 'icon': Icons.calendar_today, 'value': 'friday'},
    {'name': 'Sábado', 'icon': Icons.calendar_today, 'value': 'saturday'},
    {'name': 'Domingo', 'icon': Icons.calendar_today, 'value': 'sunday'},
  ];
}