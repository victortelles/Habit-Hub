import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_state.dart';

class HabitsList extends StatefulWidget {
  const HabitsList({super.key});

  @override
  State<HabitsList> createState() => _HabitsListState();
}

class _HabitsListState extends State<HabitsList> {
  List<String> _createdHabits = [];
  bool _loaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final appState = Provider.of<AppState>(context);

    if (!_loaded && appState.currentUser != null) {
      _loaded = true;
      _loadUserCreatedHabits(appState);
    }
  }

  // Corrección para usar el método correcto de AppState
  Future<void> _loadUserCreatedHabits(AppState appState) async {
    try {
      print("Fetching habits for: ${appState.currentUser}");
      final userCreatedHabits = await appState.getUserCreatedHabits();
      setState(() {
        _createdHabits =
            userCreatedHabits.map((habit) => habit['title'] as String).toList();
        print("Habits: $_createdHabits");
      });
    } catch (e) {
      print('Error loading habits: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("Error al cargar los hábitos: ${e.toString()}")),
        );
      }
    }
  }

  // Restauración del método _showAddHabitDialog para añadir hábitos
  void _showAddHabitDialog(BuildContext context) {
    String newHabit = '';
    List<String> selectedDays = [];
    List<String> daysOfWeek = [
      "Sunday",
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday"
    ];

    final appState = Provider.of<AppState>(context, listen: false);
    Color textcolor = appState.isDarkMode ? Colors.white : Colors.black;
    Color options_color =
        appState.isDarkMode ? Colors.white : Colors.blue.shade900;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Agregar nuevo hábito',
                  style: TextStyle(color: textcolor)),
              backgroundColor: appState.isDarkMode
                  ? Colors.grey.shade800
                  : Colors.grey.shade300,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    onChanged: (value) => newHabit = value,
                    decoration: InputDecoration(
                      hintText: 'Ej. Leer 10 min',
                      hintStyle: TextStyle(color: textcolor),
                    ),
                  ),
                  SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Selecciona los días',
                        style: TextStyle(color: textcolor)),
                  ),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 12.0,
                    runSpacing: 12.0,
                    children: daysOfWeek.map((day) {
                      final isSelected = selectedDays.contains(day);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              selectedDays.remove(day);
                            } else {
                              selectedDays.add(day);
                            }
                          });
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Color(0xFF0046A1)
                                : Color(0xFF9E9E9E),
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            day.substring(0, 3),
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child:
                      Text('Cancelar', style: TextStyle(color: options_color)),
                ),
                TextButton(
                  onPressed: () async {
                    if (newHabit.trim().isEmpty || selectedDays.isEmpty) return;

                    await appState.addUserHabit(newHabit.trim(), selectedDays);
                    Navigator.pop(context);
                    setState(() {});
                  },
                  child: Text('Crear', style: TextStyle(color: options_color)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //Declaracion de variables
    final appState = Provider.of<AppState>(context);
    print("Build user: ${appState.currentUser}");

    // Actualización del diálogo de actualización de hábito
    void showUpdateDialog(
        BuildContext context, Map<String, dynamic> currentHabit) {
      String newHabitname = currentHabit['title'];
      List<String> selectedDays = List<String>.from(currentHabit['days']);
      List<String> daysOfWeek = [
        "Sunday",
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday"
      ];
      Color textcolor = appState.isDarkMode ? Colors.white : Colors.black;
      Color options_color =
          appState.isDarkMode ? Colors.white : Colors.blue.shade900;
      showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text(
                  'Actualizar hábito',
                  style: TextStyle(color: textcolor),
                ),
                backgroundColor: appState.isDarkMode
                    ? Colors.grey.shade800
                    : Colors.grey.shade300,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Campo de texto para el nombre del hábito
                    TextFormField(
                      initialValue: newHabitname,
                      style: TextStyle(color: textcolor),
                      onChanged: (value) => newHabitname = value,
                      decoration: InputDecoration(hintText: 'Ej. Leer 10 min'),
                    ),
                    SizedBox(height: 16),
                    // Título para los días
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Selecciona los días',
                          style: TextStyle(color: textcolor)),
                    ),
                    SizedBox(height: 8),
                    // Días de la semana en diseño circular
                    Wrap(
                      spacing: 12.0,
                      runSpacing: 12.0,
                      children: daysOfWeek.map((day) {
                        final isSelected = selectedDays.contains(day);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                selectedDays.remove(day);
                              } else {
                                selectedDays.add(day);
                              }
                            });
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Color(0xFF0046A1)
                                  : Color(0xFF9E9E9E),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              day.substring(
                                  0, 3), // Mostrar solo las primeras 3 letras
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancelar',
                      style: TextStyle(color: options_color),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      // Validar si se realizaron cambios
                      bool hasTitleChanged =
                          newHabitname.trim() != currentHabit['title'];
                      bool haveDaysChanged = !Set.from(selectedDays)
                              .containsAll(currentHabit['days']) ||
                          !Set.from(currentHabit['days'])
                              .containsAll(selectedDays);
                      if (!hasTitleChanged && !haveDaysChanged) {
                        Navigator.pop(context);
                        return;
                      }
                      // Actualizar solo si hay cambios
                      await appState.updateUserHabit(
                        newHabitName:
                            hasTitleChanged ? newHabitname.trim() : null,
                        oldHabitName: currentHabit['title'],
                        selectedDays: haveDaysChanged ? selectedDays : null,
                      );
                      Navigator.pop(context);
                      _loadUserCreatedHabits(appState);
                      setState(() {});
                    },
                    child: Text(
                      'Actualizar',
                      style: TextStyle(color: options_color),
                    ),
                  ),
                ],
              );
            },
          );
        },
      );
    }

    //Dialogo para mostrar el eliminar habito
    void showDeleteDialog(BuildContext context, currentHabit) {
      Color textcolor = appState.isDarkMode ? Colors.white : Colors.black;
      Color options_color =
          appState.isDarkMode ? Colors.white : Colors.blue.shade900;
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              '¿Estás seguro de que quieres eliminar este hábito?',
              style: TextStyle(color: textcolor),
            ),
            backgroundColor: appState.isDarkMode
                ? Colors.grey.shade800
                : Colors.grey.shade300,
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'No',
                  style: TextStyle(color: options_color),
                ),
              ),
              TextButton(
                onPressed: () async {
                  await appState.deleteUserHabit(currentHabit);
                  Navigator.pop(context);
                  _loadUserCreatedHabits(appState);
                  setState(() {});
                },
                child: Text(
                  'Sí',
                  style: TextStyle(color: options_color),
                ),
              ),
            ],
          );
        },
      );
    }

    //Estructura
    return Scaffold(
      backgroundColor: appState.isDarkMode ? Colors.black : Colors.grey[200],
      body: ListView(
        children: _createdHabits.map((habitTitle) {
          final isSelected = appState.habitStatus[habitTitle] ?? false;
          return GestureDetector(
            onTap: () {
              appState.updateHabit(habitTitle, !isSelected);
            },
            child: Card(
              color: appState.isDarkMode
                  ? Colors.grey.shade800
                  : Colors.grey.shade300,
              child: ListTile(
                title: Text(
                  habitTitle,
                  style: TextStyle(
                    color: appState.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                leading: Icon(
                  Icons.check_circle,
                  color: isSelected ? Colors.blue.shade900 : Colors.grey,
                ),
                trailing: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //Actualizar
                    IconButton(
                        onPressed: () {
                          showUpdateDialog(context, {
                            'title': habitTitle,
                            'days': [],
                          });
                        },
                        icon: Icon(Icons.edit,
                            color: appState.isDarkMode
                                ? Colors.grey
                                : Colors.black)),
                    //Eliminar
                    IconButton(
                        onPressed: () {
                          showDeleteDialog(context, habitTitle);
                        },
                        icon: Icon(Icons.delete,
                            color: appState.isDarkMode
                                ? Colors.grey
                                : Colors.black)),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddHabitDialog(context),
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
