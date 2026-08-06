import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/features/home/home_controller.dart';
import 'package:tasky_app/core/components/task_item_widget.dart';

class SliverTaskListWidget extends StatelessWidget {
  const SliverTaskListWidget({
    super.key,
    
    required this.emptyMassage,
    
  });
 
  final String emptyMassage;
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>
    (
      builder:(context, controller, child) {
        return controller.isLoading
        ? SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(color: Color(0xff15B86C)),
            ),
          )
        : controller.tasks.isEmpty
        ? SliverToBoxAdapter(
            child: Center(
              child: Text(
                emptyMassage,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
          )
        : SliverPadding(
            padding: EdgeInsetsGeometry.only(bottom: 60),
            sliver: SliverList.separated(
              itemCount: controller.tasks.length,
              separatorBuilder: (context, index) {
                return SizedBox(height: 8);
              },
              itemBuilder: (context, index) {
                return TaskItemWidget(
                  onEdit: () {
                  controller.getTasks();
                  },
                  onDelete: (id) {
                    controller.deleteTask(id);
                  },
                  model: controller.tasks[index],
                  onChanged: (value) {
                    controller.doneTask(index, value);
                  },
                );
              },
            ),
          );
      },
    
     );
  }
}
