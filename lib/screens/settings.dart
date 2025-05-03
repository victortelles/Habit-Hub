import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../widgets/settings_list.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración'),
      ),
      body: ListView(
        children: [
          //Widget settings
          SettingList(
            icon: appState.isDarkMode ? Icons.brightness_3 : Icons.brightness_7,
            title: 'Modo Oscuro',
            trailing: Switch(
              value: appState.isDarkMode,
              onChanged: (value) {
                appState.toggleDarkMode();
              },
            ),
            onTap: () {
              appState.toggleDarkMode();
            },
          ),

          //Añadir mas opciones desde aqui para abjo
        ],
      ),
    );
  }
}
