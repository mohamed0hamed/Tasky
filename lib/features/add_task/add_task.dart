import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/core/widgets/custom_text_form_filed.dart';
import 'package:tasky_app/features/add_task/add_task_controller.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddTaskController>(
      create: (_) => AddTaskController(),
      builder: (context, _) {
        final controller = context.read<AddTaskController>();
        return Scaffold(
          appBar: AppBar(title: Text('New Task')),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextFormFiled(
                    controller: controller.taskNameController,
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
                    controller: controller.taskDescriptionController,
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
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Consumer<AddTaskController>(
                        builder: (context, value, child) {
                          return Switch(
                            value: value.isHighPriority,
                            onChanged: (value) {
                              controller.toggle(value);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  Spacer(),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<AddTaskController>().addtask(context);
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
      },
    );
  }
}
