import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tasky_app/core/constance/storage_key.dart';
import 'package:tasky_app/core/services/preference_manager.dart';
import 'package:tasky_app/core/widgets/custom_svg_picture_widget.dart';
import 'package:tasky_app/models/task_model.dart';
import 'package:tasky_app/features/add_task/add_task.dart';
import 'package:tasky_app/features/home/components/archieved_task_widget.dart';
import 'package:tasky_app/features/home/high_priority_tasks_widget.dart';
import 'package:tasky_app/features/home/components/sliver_task_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? fullName = 'Guest';
  String? userIamge;
  bool isLoading = false;
  List<TaskModel> tasks = [];
  int totalTacks = 0;
  int totalDaneTasks = 0;
  double precent = 0;
  @override
  void initState() {
    super.initState();
    _getFullName();
    _getTasks();
  }

  Future<void> _getFullName() async {
    setState(() {
      fullName = PreferenceManager().getString(StorageKey.userName) ?? 'Guest';
      userIamge = PreferenceManager().getString(StorageKey.userImage);
    });
  }

  Future<void> _getTasks() async {
    setState(() {
      isLoading = true;
    });
    // await Future.delayed(Duration(seconds: 2));

    final finalTask = PreferenceManager().getString(StorageKey.tasks);
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

      setState(() {
        tasks = taskAfterDecode
            .map((taskJson) => TaskModel.fromJson(taskJson))
            .toList();

        _calcPractage();
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  void _calcPractage() {
    totalTacks = tasks.length;
    totalDaneTasks = tasks.where((e) => e.isCompleted).length;
    precent = totalTacks == 0 ? 0 : totalDaneTasks / totalTacks;
  }

  Future<void> _doneTask(int? index, bool? value) async {
    setState(() {
      tasks[index!].isCompleted = value ?? false;
      _calcPractage();
    });

    final updatedTask = tasks.map((task) => task.toMap()).toList();
    await PreferenceManager().setString(StorageKey.tasks, jsonEncode(updatedTask));
  }

  Future<void> _deleteTask(int? id) async {
    if (id == null) return;
    setState(() {
      tasks.removeWhere(((element) => element.id == id));
      _calcPractage();
    });

    final updatedTask = tasks.map((task) => task.toMap()).toList();
    await PreferenceManager().setString(StorageKey.tasks, jsonEncode(updatedTask));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: userIamge == null
                              ? AssetImage('assets/images/Leading element.png')
                              : FileImage(File(userIamge!)),
                        ),

                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Good Evening , $fullName',
                              style: Theme.of(context).textTheme.titleMedium!,
                            ),
                            Text(
                              'One task at a time.One step closer.',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Yuhuu ,Your work Is ',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Row(
                      children: [
                        Text(
                          'Almost Done!',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        SizedBox(width: 8),

                        CustomSvgPictureWidget.withOutColorFilter(
                          assetName: 'assets/images/waving_hand.svg',
                          height: 32,
                          width: 32,
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    ArchievedTaskWidget(
                      totalTasks: totalTacks,
                      totalDoneTasks: totalDaneTasks,
                      precent: precent,
                    ),
                    SizedBox(height: 8),

                    HighPriorityTasksWidget(
                      tasks: tasks,
                      onTap: (bool? value, int? index) {
                        _doneTask(index, value);
                      },

                      refresh: () {
                        return _getTasks();
                      },
                    ),

                    SizedBox(height: 24),
                    Text(
                      'My Tasks',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),

              isLoading
                  ? SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color(0xff15B86C),
                        ),
                      ),
                    )
                  : SliverTaskListWidget(
                      onEdit: () => _getTasks(),
                      onDelete: (int? id) {
                        _deleteTask(id);
                      },
                      emptyMassage: 'No Data',
                      tasks: tasks,
                      onTap: (bool? value, int? index) {
                        _doneTask(index, value);
                      },
                    ),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 44,
        child: FloatingActionButton.extended(
          onPressed: () async {
            final bool? result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddTask()),
            );
            if (result != null && result) {
              _getTasks();
            }
          },
          label: Text('Add New Task'),
          icon: Icon(Icons.add),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
    );
  }
}
