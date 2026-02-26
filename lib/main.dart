import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_app/core/features/tasks/data/datasources/task_local_datasource.dart';
import 'package:task_management_app/core/features/tasks/data/repositories/task_repository_impl.dart';
import 'package:task_management_app/core/features/tasks/presentation/bloc/task_bloc.dart';
import 'package:task_management_app/core/features/tasks/presentation/bloc/task_event.dart';
import 'package:task_management_app/core/features/tasks/presentation/pages/task_list_page.dart';

void main() {
  final datasource = TaskLocalDataSource();
  final repository = TaskRepositoryImpl(datasource);

  runApp(MyApp(repository));
}

class MyApp extends StatelessWidget {
  final TaskRepositoryImpl repository;

  const MyApp(this.repository, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TaskBloc(repository)..add(LoadTasks()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.indigo,
          scaffoldBackgroundColor: const Color(0xFFF5F7FA),
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            elevation: 0,
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        home: const TaskListPage(),
      ),
    );
  }
}