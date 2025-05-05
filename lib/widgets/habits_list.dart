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

  Future<void> _loadUserCreatedHabits(AppState appState) async {
    try {
      print("Fetching habits for: ${appState.currentUser}");
      final userCreatedHabits = await appState.getUserCreatedHabits();
      setState(() {
        _createdHabits = userCreatedHabits;
        print("Habits: $_createdHabits");
      });
    } catch (e) {
      print('Error loading habits: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error al cargar los hábitos: ${e.toString()}")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final habitStatus = appState.habitStatus;
    print("Build user: ${appState.currentUser}");

    void _showAddHabitDialog(BuildContext context) {
  String newHabit = '';

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Agregar nuevo hábito'),
        content: TextField(
          onChanged: (value) => newHabit = value,
          decoration: const InputDecoration(hintText: 'Ej. Leer 10 min'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              if (newHabit.trim().isEmpty) return;

              await appState.addUserHabit(newHabit.trim());
              Navigator.pop(context);
              setState(() {});
            },
            child: const Text('Crear'),
          ),
        ],
      );
    },
  );
}

void showUpdateDialog(BuildContext context, currenthabit){
  String newHabitname = ''; 
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Actualizar hábito'),
        content: TextFormField(
          initialValue: currenthabit,
          onChanged: (value) => newHabitname = value,
          decoration: const InputDecoration(hintText: 'Ej. Leer 10 min'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              if (newHabitname.trim().isEmpty) return;

              await appState.updateUserHabit(newHabitname.trim(), currenthabit);
              Navigator.pop(context);
              _loadUserCreatedHabits(appState);
              setState(() {});
            },
            child: const Text('Actualizar'),
          ),
        ],
      );
    },
  );
}

void showDeleteDialog(BuildContext context, currentHabit){
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('¿Estás seguro de que quieres eliminar este hábito?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () async {
              await appState.deleteUserHabit(currentHabit);
              Navigator.pop(context);
              _loadUserCreatedHabits(appState);
              setState(() {});
            },
            child: const Text('Sí'),
          ),
        ],
      );
    },
  );
}


    return Scaffold(
      backgroundColor: appState.isDarkMode ? Colors.black : Colors.grey[200],
  body: ListView(
    children: habitStatus.keys.map((habit) {
      final isSelected = habitStatus[habit]!;
      return GestureDetector(
        onTap: () {
          appState.updateHabit(habit, !isSelected);
        },
        child: Card(
          color: appState.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
          child: ListTile(
            title: Text(
              habit,
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
                IconButton(
                  onPressed: (){
                    showUpdateDialog(context, habit);
                  },
                  icon: Icon(Icons.edit, color: appState.isDarkMode ? Colors.grey : Colors.black)),
                IconButton(
                  onPressed: (){
                    showDeleteDialog(context, habit);
                  },
                  icon: Icon(Icons.delete, color: appState.isDarkMode ? Colors.grey : Colors.black)),  
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

