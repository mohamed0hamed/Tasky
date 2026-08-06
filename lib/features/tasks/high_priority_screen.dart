import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/features/tasks/controllers/tasks_controller.dart';
import 'package:tasky_app/core/components/task_list_widget.dart';

class HighPriorityScreen extends StatelessWidget {
  const HighPriorityScreen({super.key});


  @override
  Widget build(BuildContext context) {
     final controller = context.read<TasksController>();
    return  Scaffold(
        appBar: AppBar(
          title: Text('High Priority Tasks'),
        ),
      
        body:  Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child:controller. isLoading
                ? Center(
                    child: CircularProgressIndicator(color: Color(0xff15B86C)),
                  )
                : Consumer<TasksController>(
                  builder: (context, value, child) {
                    return TaskListWidget(
                    onEdit: () => controller.init(),
                    onDelete: (id) => controller.deleteTask(id),
                      emptyMassage: 'No Tasks Found',
                      tasks:value. highPriorityTasks,
                      onTap: (value, index) => controller.doneHighPriorityTask(value, index),
                    );
                  },
                  
                ),
          ),
        ),
      );
  }
}
