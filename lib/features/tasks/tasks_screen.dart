import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky_app/core/services/preference_manager.dart';
import 'package:tasky_app/models/task_model.dart';
import 'package:tasky_app/core/components/task_list_widget.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<TaskModel> toDoTasks = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _getTasksNotCompleted();
  }

  Future<void> _getTasksNotCompleted() async {
    setState(() {
      isLoading = true;
    });
    
    final allTasks = PreferenceManager().getString('tasks');
    if (allTasks != null) {
      final taskAfterDecode = jsonDecode(allTasks) as List<dynamic>;

      setState(() {
        toDoTasks = taskAfterDecode
            .map((taskJson) => TaskModel.fromJson(taskJson))
            .where((taskJson) => !taskJson.isCompleted)
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
    final allTasks = PreferenceManager().getString('tasks');
    if (allTasks != null) {
      final taskAfterDecode = jsonDecode(allTasks) as List<dynamic>;
      tasks = taskAfterDecode.map((e)=> TaskModel.fromJson(e)).toList();
      tasks.removeWhere((e)=> e.id == id);
      }
    setState(() {
      toDoTasks.removeWhere(((element) => element.id == id));
     
    });

    final updatedTask = tasks.map((task) => task.toMap()).toList();
    await PreferenceManager().setString('tasks', jsonEncode(updatedTask));
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(18),
          child: Text(
            "To Do Tasks",
            style: Theme.of(context).textTheme.labelSmall
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
                  onEdit: () => _getTasksNotCompleted(),
                  onDelete: (id) {
                    _deleteTask(id);
                  },
                    emptyMassage: 'No Tasks Found',
                    tasks: toDoTasks,
                    onTap: (value, index) async {
                      setState(() {
                        toDoTasks[index!].isCompleted = value ?? false;
                      });

                      // this make big problem
                      // final prefs = await SharedPreferences.getInstance();
                      // final upDateTasks = completedTasks.map((element)=> element.toMap) .toList();
                      // await prefs.setString('tasks', jsonEncode(upDateTasks));
                      // _getTasksCompleted();

                      // solve the problem
                      
                      final allData = PreferenceManager().getString('tasks');
                      if (allData != null) {
                        List<TaskModel> allDataList =
                            (jsonDecode(allData) as List)
                                .map((element) => TaskModel.fromJson(element))
                                .toList();
                        final newIndex = allDataList.indexWhere(
                          (e) => e.id == toDoTasks[index!].id,
                        );
                        allDataList[newIndex] = toDoTasks[index!];
                        await PreferenceManager().setString(
                          'tasks',
                          jsonEncode(
                            allDataList.map((task) => task.toMap()).toList(),
                          ),
                        );
                        _getTasksNotCompleted();
                      }
                    },
                  ),
          ),
        ),
      ],
    );
  }
}
