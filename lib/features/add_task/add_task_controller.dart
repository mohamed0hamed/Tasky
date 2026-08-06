import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky_app/core/constance/storage_key.dart';
import 'package:tasky_app/core/services/preference_manager.dart';
import 'package:tasky_app/models/task_model.dart';

class AddTaskController with ChangeNotifier {
  final TextEditingController taskNameController = TextEditingController();

  final TextEditingController taskDescriptionController =
      TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isHighPriority = true;

  void addtask(BuildContext context) async {
    if (formKey.currentState?.validate() ?? false) {
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
      if (!context.mounted) return;

      Navigator.of(context).pop(true);
    }
  }

 void  toggle(bool value){
    isHighPriority = value;
    notifyListeners();
  }
}
