import 'package:flutter/material.dart';
import 'package:tasky_app/core/theme/theme_controller.dart';
import 'package:tasky_app/core/widgets/custom_check_box.dart';
import 'package:tasky_app/core/widgets/custom_svg_picture_widget.dart';
import 'package:tasky_app/models/task_model.dart';
import 'package:tasky_app/features/tasks/high_priority_screen.dart';

class HighPriorityTasksWidget extends StatelessWidget {
  const HighPriorityTasksWidget({
    super.key,
    required this.onTap,
    required this.tasks,
    required this.refresh,
  });

  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;
  // final void Function()? arrowOnTap;

  final Function refresh;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'High Priority Tasks',
                  style: TextStyle(
                    color: Color(0xff15B86C),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: tasks.where((e) => e.isHighPriority).length > 4
                      ? 4
                      : tasks.reversed.where((e) => e.isHighPriority).length,
                  itemBuilder: (context, index) {
                    final task = tasks
                        .where((e) => e.isHighPriority)
                        .toList()[index];
                    return Row(
                      children: [
                        CustomCheckBox(
                          onChanged: (value) {
                            final index = tasks.indexWhere((e) {
                              return e.id == task.id;
                            });
                            onTap(value, index);
                          },

                          value: task.isCompleted,
                        ),

                        Expanded(
                          child: Text(
                            maxLines: 1,
                            task.taskName,
                            style: task.isCompleted
                                ? Theme.of(context).textTheme.titleLarge
                                : Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ],
                    );
                  },
                ),

                // ...tasks.reversed.where((e) => e.isHighPriority).take(4).map((element) {
                //   return Row(
                //     children: [
                //       Checkbox(
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(4),
                //         ),
                //         activeColor: Color(0xff15B86C),
                //         value: element.isCompleted,
                //         onChanged: (value) {
                //           final index = tasks.indexWhere((e) {
                //             return e.id == element.id;
                //           });
                //           onTap(value, index);
                //         },
                //       ),

                //       Expanded(
                //         child: Text(
                //           maxLines: 1,
                //           element.taskName,
                //           style: TextStyle(
                //             overflow: TextOverflow.ellipsis,
                //             color: element.isCompleted
                //                 ? Color(0xff808080)
                //                 : Color(0xffFFFCFC),
                //             fontSize: 16,
                //             fontWeight: FontWeight.w400,
                //             decoration: element.isCompleted
                //                 ? TextDecoration.lineThrough
                //                 : TextDecoration.none,
                //             decorationColor: element.isCompleted
                //                 ? Color(0xff808080)
                //                 : null,
                //           ),
                //         ),
                //       ),
                //     ],
                //   );
                // }),
              ],
            ),
          ),

          GestureDetector(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return HighPriorityScreen();
                  },
                ),
              );

              refresh();
            },
            child: Container(
              padding: EdgeInsets.all(14),
              height: 56,
              width: 48,

              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                border: Border.all(
                  color: ThemeController.isDark()
                      ? Color(0xff6E6E6E)
                      : Color(0xffD1DAD6),
                ),
                shape: BoxShape.circle,
              ),
              child: CustomSvgPictureWidget(assetName:  'assets/images/arrow_up_right.svg')
            ),
          ),
        ],
      ),
    );
  }
}
