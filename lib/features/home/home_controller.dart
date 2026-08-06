import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky_app/core/constance/storage_key.dart';
import 'package:tasky_app/core/services/preference_manager.dart';
import 'package:tasky_app/models/task_model.dart';

class HomeController  extends ChangeNotifier {
  // HomeController() {
  //   init();
  // }
 String? fullName = 'Guest';
  String? userIamge;
  bool isLoading = false;
  List<TaskModel> tasks = [];
  int totalTasks = 0;
  int totalDoneTasks = 0;
  double precent = 0;

  void init() {
    getUserData();
    getTasks();
  }

  Future<void> getUserData() async {
   
      fullName = PreferenceManager().getString(StorageKey.userName) ?? 'Guest';
      userIamge = PreferenceManager().getString(StorageKey.userImage);
    
  }

  Future<void> getTasks() async {
  
      isLoading = true;
  
    // await Future.delayed(Duration(seconds: 2));

    final finalTask = PreferenceManager().getString(StorageKey.tasks);
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

    
        tasks = taskAfterDecode
            .map((taskJson) => TaskModel.fromJson(taskJson))
            .toList();

        calcPractage();
      
    }
   
      isLoading = false;
      
      notifyListeners();
  }

  void calcPractage() {
    totalTasks = tasks.length;
    totalDoneTasks = tasks.where((e) => e.isCompleted).length;
    precent = totalTasks == 0 ? 0 : totalDoneTasks / totalTasks;
    notifyListeners();
  }

  Future<void> doneTask(int? index, bool? value) async {
    
      tasks[index!].isCompleted = value ?? false;
      calcPractage();
   

    final updatedTask = tasks.map((task) => task.toMap()).toList();
    await PreferenceManager().setString(StorageKey.tasks, jsonEncode(updatedTask));
  }

  Future<void> deleteTask(int? id) async {
    if (id == null) return;
    
      tasks.removeWhere(((element) => element.id == id));
      calcPractage();
    final updatedTask = tasks.map((task) => task.toMap()).toList();
    await PreferenceManager().setString(StorageKey.tasks, jsonEncode(updatedTask));

    notifyListeners();
  }
}