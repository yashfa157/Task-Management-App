import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_app/core/features/tasks/domain/entities/task.dart';
import 'package:task_management_app/core/features/tasks/presentation/bloc/task_bloc.dart';
import 'package:task_management_app/core/features/tasks/presentation/bloc/task_event.dart';
import 'package:uuid/uuid.dart';

class AddEditTaskPage extends StatefulWidget {
  final Task? task;

  const AddEditTaskPage({super.key, this.task});

  @override
  State<AddEditTaskPage> createState() => _AddEditTaskPageState();
}

class _AddEditTaskPageState extends State<AddEditTaskPage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descController = TextEditingController();

  @override
  void initState() {
    if (widget.task != null) {
      titleController.text = widget.task!.title;
      descController.text = widget.task!.description;
    }
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.task != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? "Edit Task" : "Add Task",
          style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              /// TITLE FIELD
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: "Task Title",
                    prefixIcon: Icon(Icons.title),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(18),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter task title";
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 20),

              /// DESCRIPTION FIELD
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: descController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: "Description",
                    prefixIcon: Icon(Icons.description),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(18),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              /// SAVE BUTTON
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 6,
                  ),
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;

                    final task = Task(
                      id: widget.task?.id ?? const Uuid().v4(),
                      title: titleController.text.trim(),
                      description: descController.text.trim(),
                      dueDate: widget.task?.dueDate,
                      isCompleted: widget.task?.isCompleted ?? false,
                    );

                    if (isEditing) {
                      context.read<TaskBloc>().add(UpdateTask(task));
                    } else {
                      context.read<TaskBloc>().add(AddTask(task));
                    }

                    Navigator.pop(context);
                  },
                  child: Text(
                    isEditing ? "Update Task" : "Save Task",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
