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
  int totalTasks = 0;
  int totalDoneTasks = 0;
  double precent = 0;

  void init() {
    _loadTasks();
  }

  void _loadTasks() {
    isLoading = true;

    final finalTask = PreferenceManager().getString(StorageKey.tasks);
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

      tasks = taskAfterDecode
          .map((element) => TaskModel.fromJson(element))
          .toList();

      _loadDta();
      _calcPractage();
    }

    isLoading = false;

    notifyListeners();
  }

  void _loadDta() {
    todoTasks = tasks.where((element) => !element.isCompleted).toList();
    completeTasks = tasks.where((element) => element.isCompleted).toList();
    highPriorityTasks = highPriorityTasks
        .where((taskJson) => taskJson.isHighPriority)
        .toList();
    highPriorityTasks = highPriorityTasks.reversed.toList();
  }

  void doneTask(bool? value, int id) async {
  //final TaskModel model =   tasks.firstWhere((element) =>element.id == id );
    final index = tasks.indexWhere((e)=> e.id == id);
    tasks[index].isCompleted = value ?? false;
    _loadDta();
    _calcPractage();

    final upDateTaks = tasks.map((element) => element.toMap()).toList();

    await PreferenceManager().setString(
      StorageKey.tasks,
      jsonEncode(upDateTaks),
    );
    _loadTasks();
  }



  void deleteTask(int? id) async {
    if (id == null) return;

    tasks.removeWhere((e) => e.id == id);
    _loadDta();
    _calcPractage();

    final updatedTask = tasks.map((element) => element.toMap()).toList();
    await PreferenceManager().setString(
      StorageKey.tasks,
      jsonEncode(updatedTask),
    );

    notifyListeners();
  }

  void _calcPractage() {
    totalTasks = tasks.length;
    totalDoneTasks = tasks.where((e) => e.isCompleted).length;
    precent = totalTasks == 0 ? 0 : totalDoneTasks / totalTasks;
    notifyListeners();
  }
}
