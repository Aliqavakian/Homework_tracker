# Homework Tracker

A Flutter app for tracking homework assignments with clean architecture using BLoC state management.

## Features

- **Add Homework**: Create new homework assignments with subject, title/description, and due date
- **View Tasks**: Browse all homework in a scrollable list with completion status
- **Filter Options**: View All, Active (incomplete), or Completed tasks
- **Mark Complete**: Check off completed assignments with visual feedback
- **Local Storage**: Data persisted using SQLite database
- **Material 3**: Modern UI with light/dark theme support
- **Accessibility**: Proper semantic labels and navigation

## Architecture

- **BLoC Pattern**: State management using flutter_bloc
- **Repository Pattern**: Data layer abstraction with HomeworkRepository
- **Clean Architecture**: Separation of concerns with clear file structure
- **Navigation**: go_router for declarative routing

## Tech Stack

- Flutter 3.x / Dart 3
- flutter_bloc + equatable (state management)
- sqflite + path_provider (local database)
- go_router (navigation)
- intl (date formatting)
- Material 3 design

## Getting Started

### Prerequisites

- Flutter SDK (3.0 or higher)
- Dart SDK (3.0 or higher)
- Android Studio / VS Code
- Android emulator or iOS simulator

### Installation

1. Clone or download this project
2. Navigate to the project directory:
   ```bash
   cd homework_tracker
   ```

3. Get dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

### Running on Different Platforms

**Android:**
```bash
flutter run -d android
```

**iOS (macOS only):**
```bash
flutter run -d ios
```

**Chrome (for web testing):**
```bash
flutter run -d chrome
```

## Usage

1. **Adding Homework**: Tap the "+" button to add new assignments
2. **Marking Complete**: Tap the checkbox next to any task to toggle completion
3. **Filtering**: Use the chips at the top to filter by All/Active/Completed
4. **Visual Feedback**: Completed tasks show with strikethrough and reduced opacity

## Project Structure

```
lib/
├── main.dart                 # App entry point with routing
├── task.dart                # Domain model
├── homework_task.dart       # UI type alias
├── homework_repository.dart # Data layer
├── task_event.dart          # BLoC events
├── task_state.dart          # BLoC states
├── task_bloc.dart           # Business logic
├── homework_list_page.dart  # Main list view
├── add_homework_page.dart   # Add task form
└── homework_tile.dart       # Individual task widget
```

## Database Schema

**Table: homework**
- `id` INTEGER PRIMARY KEY AUTOINCREMENT
- `subject` TEXT NOT NULL
- `title` TEXT NOT NULL  
- `due_date_millis` INTEGER NOT NULL
- `completed` INTEGER NOT NULL (0 or 1)

## Building for Release

**Android APK:**
```bash
flutter build apk --release
```

**Android App Bundle:**
```bash
flutter build appbundle --release
```

**iOS (macOS only):**
```bash
flutter build ios --release
```

The built files will be available in the `build/` directory.

## Troubleshooting

**Common issues:**

1. **Dependencies not found**: Run `flutter pub get`
2. **Build errors**: Try `flutter clean` then `flutter pub get`
3. **Database issues**: Uninstall and reinstall the app to reset the database
4. **Navigation issues**: Ensure go_router version compatibility

For more help, see [Flutter documentation](https://docs.flutter.dev/).# Homework_tracker
