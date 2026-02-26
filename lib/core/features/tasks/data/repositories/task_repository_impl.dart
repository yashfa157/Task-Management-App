import 'package:task_management_app/core/features/tasks/data/datasources/task_local_datasource.dart';
import 'package:task_management_app/core/features/tasks/data/models/task_model.dart';
import 'package:task_management_app/core/features/tasks/domain/entities/task.dart';
import 'package:task_management_app/core/features/tasks/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource datasource;

  TaskRepositoryImpl(this.datasource);

  @override
  Future<List<Task>> getTasks() {
    return datasource.getTasks();
  }

  @override
  Future<void> addTask(Task task) {
    final model = TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      dueDate: task.dueDate,
      isCompleted: task.isCompleted,
    );

    return datasource.insertTask(model);
  }

  @override
  Future<void> updateTask(Task task) {
    final model = TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      dueDate: task.dueDate,
      isCompleted: task.isCompleted,
    );

    return datasource.updateTask(model);
  }

  @override
  Future<void> deleteTask(String id) {
    return datasource.deleteTask(id);
  }
}
