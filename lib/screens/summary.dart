import 'package:flutter/material.dart';
import '../data/personalization_data.dart';
import '../models/user_preferences.dart';

class Summary extends StatelessWidget {
  final UserPreferences userPreferences;

  const Summary({
    super.key,
    required this.userPreferences,
  });

  String _getGenderName() {
    if (userPreferences.gender == null) return 'No seleccionado';
    final gender = PersonalizationData.genderOptions.firstWhere(
      (g) => g['value'] == userPreferences.gender,
      orElse: () => {'name': 'No seleccionado', 'value': ''},
    );
    return gender['name'];
  }

  List<String> _getSelectedNames(
    List<String> selectedValues, List<Map<String, dynamic>> options) {

    // Explícitamente define que devuelves una lista/arreglos de strings
    return selectedValues.map<String>((value) {
      final option = options.firstWhere(
        (opt) => opt['value'] == value,
        orElse: () => {'name': value, 'value': value},
      );

      // Forzar a que regrese String
      return option['name'] as String;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final habitNames = _getSelectedNames(userPreferences.selectedHabits, PersonalizationData.habitOptions);
    final exerciseNames = _getSelectedNames(userPreferences.selectedExercises, PersonalizationData.exerciseOptions);
    final sportNames = _getSelectedNames(userPreferences.selectedSports, PersonalizationData.sportOptions);
    final dayNames = _getSelectedNames(userPreferences.selectedDays, PersonalizationData.dayOptions);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Resumen', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                '¡Gracias por completar tu perfil!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              //Espaciado
              const SizedBox(height: 8),

              // Texto
              const Text(
                'Aquí está un resumen de tus preferencias:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),

              //Espaciado
              const SizedBox(height: 24),

              //Armar la lista de resumen
              Expanded(
                child: ListView(
                  children: [
                    _buildSummaryCard(
                      context,
                      'Género',
                      [_getGenderName()],
                      Icons.person,
                    ),
                    _buildSummaryCard(
                      context,
                      'Hábitos',
                      habitNames,
                      Icons.checklist,
                    ),
                    _buildSummaryCard(
                      context,
                      'Ejercicios',
                      exerciseNames,
                      Icons.fitness_center,
                    ),
                    _buildSummaryCard(
                      context,
                      'Deportes',
                      sportNames,
                      Icons.sports,
                    ),
                    _buildSummaryCard(
                      context,
                      'Días preferidos',
                      dayNames,
                      Icons.calendar_today,
                    ),
                  ],
                ),
              ),

              //Espaciado
              const SizedBox(height: 16),

              //Botón
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Aquí iría la navegación al home o la lógica para guardar las preferencias

                    // Mostrar un SnackBar
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('¡Perfil completado! Redirigiendo al home...'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Comenzar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
    BuildContext context,
    String title,
    List<String> items,
    IconData icon,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Theme.of(context).primaryColor),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: items
                .map((item) => Chip(
                      label: Text(item),
                      backgroundColor:
                          Theme.of(context).primaryColor.withOpacity(0.1),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
