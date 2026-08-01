import 'package:flutter/material.dart';
import 'package:tasky_app/models/task_model.dart';
import 'package:tasky_app/widgets/task_item_widget.dart';

class SliverTaskListWidget extends StatelessWidget {
  const SliverTaskListWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.emptyMassage, required this.onDelete, required this.onEdit,
  });
  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;
  final Function (int?) onDelete;
   final Function onEdit ;
  final String emptyMassage;
  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
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
              itemCount: tasks.length,
              separatorBuilder: (context, index) {
                return SizedBox(height: 8);
              },
              itemBuilder: (context, index) {
                return TaskItemWidget(
                  onEdit: () {
                    onEdit();
                  },
                  onDelete: (id){
                    onDelete(id);
                  },
                  model: tasks[index],
                  onChanged: (value) {
                    onTap(value, index);
                  },
                );
              },
            ),
          );
  }
}
