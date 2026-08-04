import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/core/widgets/custom_svg_picture_widget.dart';
import 'package:tasky_app/features/home/home_controller.dart';
import 'package:tasky_app/features/add_task/add_task.dart';
import 'package:tasky_app/features/home/components/archieved_task_widget.dart';
import 'package:tasky_app/features/home/high_priority_tasks_widget.dart';
import 'package:tasky_app/features/home/components/sliver_task_list_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeController()..init(),
      child: Consumer<HomeController>(
        builder: (context, value, child) {
          final HomeController controller = context.read<HomeController>();
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
                                backgroundImage: value.userIamge == null
                                    ? AssetImage(
                                        'assets/images/Leading element.png',
                                      )
                                    : FileImage(File(value.userIamge!)),
                              ),

                              SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Good Evening , ${value.fullName}',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium!,
                                  ),
                                  Text(
                                    'One task at a time.One step closer.',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleSmall,
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
                            totalTasks: value.totalTacks,
                            totalDoneTasks: value.totalDaneTasks,
                            precent: value.precent,
                          ),
                          SizedBox(height: 8),

                          HighPriorityTasksWidget(
                            tasks: value.tasks,
                            onTap: (bool? value, int? index) {
                              controller.doneTask(index, value);
                            },

                            refresh: () {
                              return controller.getTasks();
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

                    value.isLoading
                        ? SliverToBoxAdapter(
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Color(0xff15B86C),
                              ),
                            ),
                          )
                        : SliverTaskListWidget(
                            onEdit: () => controller.getTasks(),
                            onDelete: (int? id) {
                              controller.deleteTask(id);
                            },
                            emptyMassage: 'No Data',
                            tasks: value.tasks,
                            onTap: (bool? value, int? index) {
                              controller.doneTask(index, value);
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
                    controller.getTasks();
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
        },
      ),
    );
  }
}
