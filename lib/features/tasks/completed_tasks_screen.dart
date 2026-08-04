import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky_app/core/constance/storage_key.dart';
import 'package:tasky_app/core/services/preference_manager.dart';
import 'package:tasky_app/models/task_model.dart';
import 'package:tasky_app/core/components/task_list_widget.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({super.key});

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  List<TaskModel> completedTasks = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _getTasksCompleted();
  }

  Future<void> _getTasksCompleted() async {
    setState(() {
      isLoading = true;
    });
    
    final allTasks = PreferenceManager().getString(StorageKey.tasks);
    if (allTasks != null) {
      final taskAfterDecode = jsonDecode(allTasks) as List<dynamic>;

      setState(() {
        completedTasks = taskAfterDecode
            .map((taskJson) => TaskModel.fromJson(taskJson))
            .where((taskJson) => taskJson.isCompleted)
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
      tasks = taskAfterDecode.map((e) => TaskModel.fromJson(e),).toList();
      tasks.removeWhere((e)=>e.id == id);
      }

    setState(() {
      completedTasks.removeWhere(((element) => element.id == id));
    });

    final updatedTask = tasks.map((task) => task.toMap()).toList();
    await PreferenceManager().setString(StorageKey.tasks, jsonEncode(updatedTask));
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            'Completed Tasks',
            style:Theme.of(context).textTheme.labelSmall
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(color: Color(0xff15B86C)),
                  )
                : TaskListWidget(
                  onEdit: () => _getTasksCompleted(),
                  onDelete: (id) {
                    _deleteTask(id);
                  },
                    emptyMassage: 'No Tasks Found',
                    tasks: completedTasks,
                    onTap: (value, index) async {
                      setState(() {
                        completedTasks[index!].isCompleted = value ?? false;
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
                          (e) => e.id == completedTasks[index!].id,
                        );
                        allDataList[newIndex] = completedTasks[index!];
                        await PreferenceManager().setString(
                          StorageKey.tasks,
                          jsonEncode(
                            allDataList.map((task) => task.toMap()).toList(),
                          ),
                        );
                        _getTasksCompleted();
                      }
                    },
                  ),
          ),
        ),
      ],
    );
  }
}
