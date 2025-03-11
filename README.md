# HabitHub
HabitHub es una aplicación móvil diseñada para transformar el hábito del ejercicio físico en una experiencia motivadora y social. La aplicación se enfoca en ayudar a los usuarios a establecer, mantener y disfrutar de rutinas de ejercicio personalizadas mediante un enfoque gamificado y centrado en la comunidad.

# Características principales

- Seguimiento personalizado de actividades físicas y progreso
- Recomendaciones inteligentes de rutinas basadas en tu perfil
- Rutinas estructuradas con progresión gradual de dificultad
- Sistema de retos locales para conectar con usuarios cercanos
- Gamificación con recompensas, rachas y logros desbloqueables

# Requisitos previos
> [!IMPORTANT]
> Importante tener las siguientes versiones.

- `Flutter: Version: 3.27.2 o Superior`
- `Dart SDK version: 3.6.1 o Superior`

# Instalación
1. Clonar el repositorio
```bash
git clone https://github.com/victortelles/Habit-Hub.git
```
```bash
cd Habit-Hub
```
2. Instalar dependencias
```bash
flutter pub get
```
3. Configurar variables de entorno (si es necesario)
Crea un archivo .env en la raíz del proyecto basándote en el archivo .env.example.

4. Ejecutar la aplicación
```bash
flutter run
```

Para ejecutar en un dispositivo específico:
```bash
flutter devices                  # Lista los dispositivos disponibles
flutter run -d <device_id>       # Ejecuta en el dispositivo especificado
```

## Dependencias del proyecto
*Aqui iran las dependencias del proyecto + su*


# Estructura del proyecto
> [!NOTE]
> *Esta estructura no es oficial a seguir es una referencia*

```bash
lib/
  ├── main.dart                      # Punto de entrada de la aplicación
  ├── data/                          # Capa de datos
  │   ├── api/                       # Servicios de API
  │   ├── providers/                 # Proveedores de estado
  │   └── repositories/              # Repositorios
  ├── models/                        # Modelos de datos
  ├── screens/                       # Pantallas de la aplicación
  │   ├── auth/                      # Autenticación
  │   ├── home/                      # Pantalla principal
  │   ├── workout/                   # Ejercicios
  │   ├── routine/                   # Rutinas
  │   ├── challenge/                 # Retos
  │   └── profile/                   # Perfil de usuario
  ├── widgets/                       # Componentes de UI reutilizables
  │   ├── common/                    # Widgets comunes
  │   ├── workout/                   # Widgets de ejercicios
  │   └── challenge/                 # Widgets de retos
  └── utils/                         # Utilidades y herramientas
```

# habit_hub

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
