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
  int totalTacks = 0;
  int totalDaneTasks = 0;
  double precent = 0;

  void init() {
    getFullName();
    getTasks();
  }

  Future<void> getFullName() async {
   
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
    totalTacks = tasks.length;
    totalDaneTasks = tasks.where((e) => e.isCompleted).length;
    precent = totalTacks == 0 ? 0 : totalDaneTasks / totalTacks;
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