

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky_app/core/constance/storage_key.dart';
import 'package:tasky_app/core/services/preference_manager.dart';
import 'package:tasky_app/models/task_model.dart';

class TasksController extends ChangeNotifier {
  bool isLoading = false;

  List<TaskModel> tasks = [];
  List<TaskModel> completeTasks = [];
  List<TaskModel> todoTasks = [];
   List<TaskModel> highPriorityTasks = [];

 void init() {
    _loadTasks();
  }

  void _loadTasks() {
    isLoading = true;

    final finalTask = PreferenceManager().getString(StorageKey.tasks);
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

      tasks = taskAfterDecode.map((element) => TaskModel.fromJson(element)).toList();
      todoTasks = tasks.where((element) => !element.isCompleted).toList();
      completeTasks = tasks.where((element) => element.isCompleted).toList();
      highPriorityTasks = highPriorityTasks
            .where((taskJson) => taskJson.isHighPriority)
            .toList();
      // calculatePercent();
    }

    isLoading = false;

    notifyListeners();
  }

  void doneTask(bool? value, int? index) async {
    if (index == null) return;
    todoTasks[index].isCompleted = value ?? false;

    final int newIndex = tasks.indexWhere((e) => e.id == todoTasks[index].id);
    tasks[newIndex] = todoTasks[index];

    await PreferenceManager().setString(StorageKey.tasks, jsonEncode(tasks));
    _loadTasks();
  }

  void doneCompleteTask(bool? value, int? index) async {
    if (index == null) return;
    completeTasks[index].isCompleted = value ?? false;

    final int newIndex = tasks.indexWhere((e) => e.id == completeTasks[index].id);
    tasks[newIndex] = completeTasks[index];

    await PreferenceManager().setString(StorageKey.tasks, jsonEncode(tasks));
    _loadTasks();
  }




   void doneHighPriorityTask(bool? value, int? index) async {
    if (index == null) return;
    highPriorityTasks[index].isCompleted = value ?? false;

    final int newIndex = tasks.indexWhere((e) => e.id == highPriorityTasks[index].id);
    tasks[newIndex] = highPriorityTasks[index];

    await PreferenceManager().setString(StorageKey.tasks, jsonEncode(tasks));
    _loadTasks();
   }


   void  deleteTask(int? id) async {
    if (id == null) return;

    tasks.removeWhere((e) => e.id == id);
    todoTasks.removeWhere((task) => task.id == id);
    completeTasks.removeWhere((task) => task.id == id);
    highPriorityTasks.removeWhere((task) => task.id == id);

    final updatedTask = tasks.map((element) => element.toMap()).toList();
    await PreferenceManager().setString(StorageKey.tasks, jsonEncode(updatedTask));

    notifyListeners();
  }
   
}