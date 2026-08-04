import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tasky_app/core/constance/storage_key.dart';
import 'package:tasky_app/core/services/preference_manager.dart';
import 'package:tasky_app/core/widgets/custom_text_form_filed.dart';
import 'package:tasky_app/models/task_model.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController taskNameController = TextEditingController();

  final TextEditingController taskDescriptionController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isHighPriority = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Task')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFormFiled(
                
                controller: taskNameController,
                hintText: 'Finish UI design for login screen',
                title: 'Task Name',
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a task name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 28),
              CustomTextFormFiled(
                
                maxLines: 5,
                controller: taskDescriptionController,
                hintText:
                    'Finish onboarding UI and hand off to devs by Thursday.',
                title: 'Task Description',
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'High Priority',
                    style: Theme.of(context).textTheme.titleMedium
                  ),
                  Switch(
                    value: isHighPriority,
                    onChanged: (value) {
                      setState(() {
                        isHighPriority = value;
                      });
                    },
                  ),
                ],
              ),
              Spacer(),
              ElevatedButton.icon(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    final taskJson = PreferenceManager().getString(StorageKey.tasks);

                    List<dynamic> taskList = [];
                    if (taskJson != null) {
                      taskList = jsonDecode(taskJson) as List<dynamic>;
                    }
                    final TaskModel task = TaskModel(
                      id: taskList.length + 1,
                      taskName: taskNameController.text,
                      taskDescription: taskDescriptionController.text,
                      isHighPriority: isHighPriority,
                    );

                    taskList.add(task.toMap());
                    final taskEncoded = jsonEncode(taskList);

                    await PreferenceManager().setString(StorageKey.tasks, taskEncoded);

                   Navigator.of(context).pop(true);
                  }
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width, 40),
                ),
                icon: Icon(Icons.add),
                label: Text('Add Task'),
              ),

              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
