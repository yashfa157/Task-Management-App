import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_app/core/features/tasks/domain/entities/task.dart';
import 'package:task_management_app/core/features/tasks/domain/repositories/task_repository.dart';
import 'task_event.dart';
import 'task_state.dart';
import 'task_filter.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository repository;

  List<Task> _allTasks = [];
  TaskFilter _filter = TaskFilter.all;
  String _search = "";

  TaskBloc(this.repository) : super(TaskLoading()) {
    on<LoadTasks>((event, emit) async {
      _allTasks = await repository.getTasks();
      emit(_buildState());
    });

    on<AddTask>((event, emit) async {
      await repository.addTask(event.task);
      _allTasks = await repository.getTasks();
      emit(_buildState());
    });

    on<UpdateTask>((event, emit) async {
      await repository.updateTask(event.task);
      _allTasks = await repository.getTasks();
      emit(_buildState());
    });

    on<DeleteTask>((event, emit) async {
      await repository.deleteTask(event.id);
      _allTasks = await repository.getTasks();
      emit(_buildState());
    });

    on<ToggleTaskStatus>((event, emit) async {
      final updated = event.task.copyWith(isCompleted: !event.task.isCompleted);

      await repository.updateTask(updated);
      _allTasks = await repository.getTasks();
      emit(_buildState());
    });

    on<SearchTasks>((event, emit) {
      _search = event.query;
      emit(_buildState());
    });

    on<ChangeFilter>((event, emit) {
      _filter = event.filter;
      emit(_buildState());
    });
  }

  TaskLoaded _buildState() {
    List<Task> tasks = _allTasks;

    if (_filter == TaskFilter.completed) {
      tasks = tasks.where((t) => t.isCompleted).toList();
    }

    if (_filter == TaskFilter.pending) {
      tasks = tasks.where((t) => !t.isCompleted).toList();
    }

    if (_search.isNotEmpty) {
      tasks = tasks
          .where((t) => t.title.toLowerCase().contains(_search.toLowerCase()))
          .toList();
    }

    return TaskLoaded(tasks: tasks, filter: _filter, searchQuery: _search);
  }
}
