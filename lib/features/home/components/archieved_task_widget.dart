import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/features/tasks/controllers/tasks_controller.dart';

class ArchievedTaskWidget extends StatelessWidget {
  const ArchievedTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return   Consumer<TasksController>(
      builder: (context, controller, child)
      {
         return Container(
                  padding: EdgeInsets.all(16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Achieved Tasks',
                            style: Theme.of(context).textTheme.titleMedium
                          ),
                          SizedBox(height: 4),
                          Text(
                            "${controller.totalDoneTasks} Out of ${controller.totalTasks} Done",
                            style: Theme.of(context).textTheme.titleSmall
                          ),
                        ],
                      ),
      
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Transform.rotate(
                            angle: -pi / 2,
                            child: SizedBox(
                              height: 48,
                              width: 48,
                              child: CircularProgressIndicator(
                                value: controller.precent,
                                valueColor: AlwaysStoppedAnimation(
                                  Color(0xff15B86C),
                                ),
      
                                backgroundColor: Color(0xff6D6D6D),
                              ),
                            ),
                          ),
      
                          Text(
                            "${(controller.precent * 100).toInt()}%",
                            style: Theme.of(context).textTheme.titleMedium
                          ),
                        ],
                      ),
                    ],
                  ),
                );
      }
     
    );
  }
}