import 'package:flutter/material.dart';
import '../data/personalization_data.dart';
import '../models/user_preferences.dart';
import '../widgets/personalization_page.dart';
import 'habits_selection.dart';

class GenderSelection extends StatefulWidget {
  final UserPreferences userPreferences;

  const GenderSelection({
    super.key,
    required this.userPreferences,
  });

  @override
  State<GenderSelection> createState() => _GenderSelectionState();
}

class _GenderSelectionState extends State<GenderSelection> {
  late UserPreferences _userPreferences;

  @override
  void initState() {
    super.initState();
    _userPreferences = widget.userPreferences;
  }

  //Funcionalidad al seleccionar el genero.
  void _onGenderSelected(String gender) {
    setState(() {
      if (_userPreferences.gender == gender) {
        _userPreferences.gender == null;
      } else {
        _userPreferences.gender = gender;
      }
    });
  }

  //Navegar a la siguiente pantalla.
  void _navigateToNext() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => HabitsSelection(
          userPreferences: _userPreferences,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Pantalla para seleccionar el genero.
    return PersonalizationPage(
      title: 'Personalizacion',
      instructionText: 'Selecciona tu genero',
      options: PersonalizationData.genderOptions,
      selectedValues: _userPreferences.gender != null ? [_userPreferences.gender!]: [],
      onOptionSelected: _onGenderSelected,
      onNext: _navigateToNext,
      showSelection: false,
    );
  }
}