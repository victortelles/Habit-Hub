import 'package:flutter/material.dart';
import 'option_card.dart';

class PersonalizationPage extends StatelessWidget {
  final String title;
  final String instructionText;
  final List<Map<String, dynamic>> options;
  final List<String> selectedValues;
  final Function(String) onOptionSelected;
  final VoidCallback onNext;
  final int maxSelections;
  final bool showSelection;

  const PersonalizationPage({
    super.key,
    required this.title,
    required this.instructionText,
    required this.options,
    required this.selectedValues,
    required this.onOptionSelected,
    required this.onNext,
    this.maxSelections = 0,
    this.showSelection = true,
  });

  @override
  Widget build(BuildContext context) {
    //Color principal
    final Color primaryColor = const Color(0xFF3942FF);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF2196F3),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        centerTitle: true,
      ),

      //Espaciado
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),

          //Column
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //Texto de instruccion
              Text(
                instructionText,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              //Espaciado
              const SizedBox(height: 8),

              //Condicional
              if (maxSelections > 0)
                Text(
                  'Selecciona hasta $maxSelections opciones',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),

              //Espaciado
              const SizedBox(height: 16),

              //Lista gridview
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    final option = options[index];
                    final isSelected = selectedValues.contains(option['value']);

                    return OptionCard(
                      title: option['name'],
                      icon: option['icon'],
                      isSelected: isSelected,
                      onTap: () {
                        //Verificar limite de Selecciones
                        if (maxSelections > 0 && selectedValues.length >= maxSelections && !isSelected) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Solo puedes seleccionar hasta $maxSelections opciones'),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                          return;
                        }
                        onOptionSelected(option['value']);
                      },
                    );
                  },
                ),
              ),

              //Espaciado
              const SizedBox(height: 16),

              if (showSelection)
                //Contenedor
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),

                  //Columna Seleccionados
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Seleccionados:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      //Espaciado
                      const SizedBox(height: 8),

                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: selectedValues.map((value) {
                          final option = options.firstWhere(
                            (opt) => opt['value'] == value,
                            orElse: () => {'name': value, 'value': value},
                          );
                          return Chip(
                            label: Text(option['name']),
                            onDeleted: () => onOptionSelected(value),
                            backgroundColor: primaryColor.withOpacity(0.1),
                            deleteIconColor: primaryColor,
                            labelStyle: TextStyle(color: primaryColor),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),

              //Espaciado
              const SizedBox(height: 16),

              //boton inferior
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedValues.isNotEmpty ? onNext : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Text(
                    'Siguiente',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}