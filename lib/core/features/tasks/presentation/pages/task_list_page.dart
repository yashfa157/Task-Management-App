import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_app/core/features/tasks/presentation/bloc/task_bloc.dart';
import 'package:task_management_app/core/features/tasks/presentation/bloc/task_event.dart';
import 'package:task_management_app/core/features/tasks/presentation/bloc/task_filter.dart';
import 'package:task_management_app/core/features/tasks/presentation/bloc/task_state.dart';
import 'add_edit_task_page.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Task Manager",
          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo, Colors.deepPurple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// SEARCH BAR
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: "Search tasks...",
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 16),
                ),
                onChanged: (value) {
                  context.read<TaskBloc>().add(SearchTasks(value));
                },
              ),
            ),

            const SizedBox(height: 16),

            /// FILTER DROPDOWN
            BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                if (state is! TaskLoaded) {
                  return const SizedBox();
                }

                return Align(
                  alignment: Alignment.centerRight,
                  child: DropdownButton<TaskFilter>(
                    value: state.filter,
                    underline: const SizedBox(),
                    borderRadius: BorderRadius.circular(12),
                    items: const [
                      DropdownMenuItem(
                        value: TaskFilter.all,
                        child: Text("All"),
                      ),
                      DropdownMenuItem(
                        value: TaskFilter.completed,
                        child: Text("Completed"),
                      ),
                      DropdownMenuItem(
                        value: TaskFilter.pending,
                        child: Text("Pending"),
                      ),
                    ],
                    onChanged: (filter) {
                      context.read<TaskBloc>().add(ChangeFilter(filter!));
                    },
                  ),
                );
              },
            ),

            const SizedBox(height: 12),

            /// TASK LIST
            Expanded(
              child: BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  if (state is TaskLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is TaskLoaded) {
                    if (state.tasks.isEmpty) {
                      return const Center(
                        child: Text(
                          "No tasks yet",
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: state.tasks.length,
                      itemBuilder: (context, index) {
                        final task = state.tasks[index];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            leading: Transform.scale(
                              scale: 1.2,
                              child: Checkbox(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                value: task.isCompleted,
                                onChanged: (_) {
                                  context.read<TaskBloc>().add(
                                    ToggleTaskStatus(task),
                                  );
                                },
                              ),
                            ),
                            title: Text(
                              task.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                decoration: task.isCompleted
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                task.description,
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => AddEditTaskPage(task: task),
                                ),
                              );
                            },
                            trailing: IconButton(
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () {
                                context.read<TaskBloc>().add(
                                  DeleteTask(task.id),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),

      /// ADD BUTTON
      floatingActionButton: FloatingActionButton(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddEditTaskPage()),
          );
        },
      ),
    );
  }
}
