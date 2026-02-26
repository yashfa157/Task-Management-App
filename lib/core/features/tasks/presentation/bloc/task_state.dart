import 'package:task_management_app/core/features/tasks/domain/entities/task.dart';
import 'package:task_management_app/core/features/tasks/presentation/bloc/task_filter.dart';

abstract class TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;
  final TaskFilter filter;
  final String searchQuery;

  TaskLoaded({
    required this.tasks,
    required this.filter,
    required this.searchQuery,
  });
}
