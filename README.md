# Task Management App (Flutter)

A simple **Task Management App** built with Flutter demonstrating **CRUD operations**, **local database persistence using Sqflite**, **BLoC state management**, and **clean architecture principles**.  

This project was created as part of a **Flutter internship technical task**.

---

## **Features**

- **CRUD Operations**:
  - Add a new task (title, description)
  - View all tasks
  - Edit/update existing task
  - Delete task
  - Mark task as completed/incomplete

- **Local Database**:
  - Tasks are stored locally using **Sqflite** (persist after app restart)
  - Proper database table and model structure implemented

- **Filtering & Searching**:
  - Filter tasks: All / Completed / Pending
  - Search tasks by title or description

- **UI**:
  - Clean, modern, and responsive UI
  - Gradient app bars, rounded task cards, shadows
  - Input validation in Add/Edit Task screen

- **State Management**:
  - **BLoC** (Business Logic Component)
  - Clear separation of UI and business logic

---

## **Project Structure**

```

lib/
├── core.features.tasks/
│   ├── data/
│   │   ├── datasources/task_local_datasource.dart
│   │   ├── models/task_model.dart
│   │   └── repositories/task_repository_impl.dart
│   ├── domain/
│   │   ├── entities/task.dart
│   │   ├── repositories/task_repository.dart
│   │   └── usecases/
│   └── presentation/
│       ├── bloc/
│       │   ├── task_bloc.dart
│       │   ├── task_event.dart
│       │   ├── task_state.dart
│       │   └── task_filter.dart
│       ├── pages/
│       │   ├── add_edit_task_page.dart
│       │   └── task_list_page.dart
│       └── widgets/
└── main.dart

````

---

## **Packages Used**

- [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) – State management  
- [`equatable`](https://pub.dev/packages/equatable) – Compare objects in Bloc  
- [`sqflite`](https://pub.dev/packages/sqflite) – Local database for persistence  
- [`path`](https://pub.dev/packages/path) – Database file paths  
- [`intl`](https://pub.dev/packages/intl) – Format dates  
- [`uuid`](https://pub.dev/packages/uuid) – Generate unique task IDs  

**Dev Dependencies:**

- [`bloc_test`](https://pub.dev/packages/bloc_test) – Unit testing BLoC  
- [`mocktail`](https://pub.dev/packages/mocktail) – Mocking dependencies for tests  
- [`flutter_lints`](https://pub.dev/packages/flutter_lints) – Recommended linting rules  

---

## **Setup Instructions**

1. Clone the repository:

```bash
git clone <https://github.com/yashfa157/Task-Management-App>
cd <your path where folder is stored>
````

2. Install dependencies:

```bash
flutter pub get
```

3. Run the app:

```bash
flutter run
```

4. **Database initialization** is handled automatically in `task_local_datasource.dart` using **Sqflite**.

---

## **💡 Architecture**

* **Clean Architecture**: Separates layers into **data, domain, and presentation**
* **Data Layer**: Handles local database operations and repository implementation
* **Domain Layer**: Defines Task entity and repository interface
* **Presentation Layer**: UI screens + BLoC for state management
* **OOP Principles**: Encapsulation, abstraction, modularity
* **Modularity**: All logic and UI components are separated into folders

---

## **Optional Features / Bonuses Implemented**

* Filtering (All / Completed / Pending)
* Task search functionality
* Input validation for required fields
* Proper error handling

---

## **Notes**

* Tasks persist locally using **Sqflite**
* UI is modern, clean, and responsive
* Fully modular and maintainable code
* Suitable for Flutter internships or beginner projects

---

## **Author**

**Yashfa Najam**
[GitHub Profile](https://github.com/yashfa157)

```
