import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky_app/core/constance/storage_key.dart';
import 'package:tasky_app/core/services/preference_manager.dart';
import 'package:tasky_app/models/task_model.dart';
import 'package:tasky_app/core/components/task_list_widget.dart';

class HighPriorityScreen extends StatefulWidget {
  const HighPriorityScreen({super.key});

  @override
  State<HighPriorityScreen> createState() => _HighPriorityScreenState();
}

class _HighPriorityScreenState extends State<HighPriorityScreen> {
  List<TaskModel> highPriorityTasks = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _getTasksIsHighPriority();
  }

  Future<void> _getTasksIsHighPriority() async {
    setState(() {
      isLoading = true;
    });
    
    final allTasks = PreferenceManager().getString(StorageKey.tasks);
    if (allTasks != null) {
      final taskAfterDecode = jsonDecode(allTasks) as List<dynamic>;

      setState(() {
        highPriorityTasks = taskAfterDecode
            .map((taskJson) => TaskModel.fromJson(taskJson))
            .where((taskJson) => taskJson.isHighPriority)
            .toList();
      });
    }

    setState(() {
      isLoading = false;
    });
  }

   Future<void> _deleteTask(int? id) async {
    if(id == null)return;

    List<TaskModel> tasks = [];
    final allTasks = PreferenceManager().getString(StorageKey.tasks);
    if (allTasks != null) {
      final taskAfterDecode = jsonDecode(allTasks) as List<dynamic>;
      tasks = taskAfterDecode.map((e)=> TaskModel.fromJson(e)).toList();
      tasks.removeWhere((e)=> e.id == id);
      }


    setState(() {
      highPriorityTasks.removeWhere(((element) => element.id == id));
    });

    final updatedTask = tasks.map((task) => task.toMap()).toList();
    await PreferenceManager().setString(StorageKey.tasks, jsonEncode(updatedTask));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('High Priority Tasks'),
      ),

      body:  Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(color: Color(0xff15B86C)),
                )
              : TaskListWidget(
                onEdit: () => _getTasksIsHighPriority(),
                onDelete: (id) {
                  _deleteTask(id);
                },
                  emptyMassage: 'No Tasks Found',
                  tasks: highPriorityTasks,
                  onTap: (value, index) async {
                    setState(() {
                      highPriorityTasks[index!].isCompleted = value ?? false;
                    });
                    // this make big problem
                    // final prefs = await SharedPreferences.getInstance();
                    // final upDateTasks = completedTasks.map((element)=> element.toMap) .toList();
                    // await prefs.setString('tasks', jsonEncode(upDateTasks));
                    // _getTasksCompleted();
                
                    // solve the problem
                
                    final allData = PreferenceManager().getString(StorageKey.tasks);
                    if (allData != null) {
                      List<TaskModel> allDataList =
                          (jsonDecode(allData) as List)
                              .map((element) => TaskModel.fromJson(element))
                              .toList();
                      final newIndex = allDataList.indexWhere(
                        (e) => e.id == highPriorityTasks[index!].id,
                      );
                      allDataList[newIndex] = highPriorityTasks[index!];
                      await PreferenceManager().setString(
                        StorageKey.tasks,
                        jsonEncode(
                          allDataList.map((task) => task.toMap()).toList(),
                        ),
                      );
                      _getTasksIsHighPriority();
                    }
                  },
                ),
        ),
      ),
    )
    ;
  }
}
