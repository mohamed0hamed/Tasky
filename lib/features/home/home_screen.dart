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
      child: Scaffold(
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
                          Selector<HomeController, String?>(
                            selector: (context, HomeController controller) =>
                                controller.userIamge,
                            builder: (context, userImage, child) {
                              return CircleAvatar(
                                backgroundImage: userImage == null
                                    ? AssetImage(
                                        'assets/images/Leading element.png',
                                      )
                                    : FileImage(File(userImage)),
                              );
                            },
                          ),

                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Selector<HomeController, String?>(
                                selector: (context, controller) =>
                                    controller.fullName,
                                builder: (context, String? fullName, child) {
                                  return Text(
                                    'Good Evening , $fullName',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium!,
                                  );
                                },
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
                      ArchievedTaskWidget(),
                      SizedBox(height: 8),
                      HighPriorityTasksWidget(),
                      SizedBox(height: 24),
                      Text(
                        'My Tasks',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),

                SliverTaskListWidget(emptyMassage: 'No Data'),
              ],
            ),
          ),
        ),
        floatingActionButton: SizedBox(
          height: 44,
          child: Builder(builder:(context) {
            return FloatingActionButton.extended(
            onPressed: () async {
              final bool? result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTask()),
              );
              if (result != null && result) {
                context.read<HomeController>().getTasks();
              }
            },
            label: Text('Add New Task'),
            icon: Icon(Icons.add),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          );
          },),
        ),
      ),
    );
  }
}
