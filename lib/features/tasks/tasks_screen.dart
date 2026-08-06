import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/features/tasks/controllers/tasks_controller.dart';
import 'package:tasky_app/core/components/task_list_widget.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
     final controller = context.read<TasksController>();
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(18),
              child: Text(
                "To Do Tasks",
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: controller.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Color(0xff15B86C),
                        ),
                      )
                    : Consumer<TasksController>(
                        builder: (context, valueController, child) {
                          return TaskListWidget(
                            tasks: valueController.todoTasks,
                            onEdit: () => controller.init(),
                            onDelete: (id) => controller.deleteTask(id),
                            emptyMassage: 'No Tasks Found',
                            onTap: (value, index) async {
                              controller.doneTask(value, valueController.todoTasks[index!].id);
                            },
                          );
                        },
                      ),
              ),
            ),
          ],
        );
  }
}
