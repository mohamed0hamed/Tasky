import 'package:flutter/material.dart';
import 'package:tasky_app/models/task_model.dart';
import 'package:tasky_app/widgets/task_item_widget.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.emptyMassage,
     required this.onDelete,
     required this.onEdit,
  });
  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;
  final Function (int? id) onDelete;
  final Function onEdit ;
  final String emptyMassage;
  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? Center(
            child: Text(
              emptyMassage,
              style: Theme.of(context).textTheme.displaySmall,
            ),
          )
        : ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: tasks.length,
            padding: EdgeInsets.only(bottom: 60),
            separatorBuilder: (context, index) {
              return SizedBox(height: 8);
            },
            itemBuilder: (context, index) {
              return TaskItemWidget(
                onEdit: () {
                  onEdit();
                },
                onDelete: (id) {
                  onDelete (id);
                },
                model: tasks[index],

                onChanged: (value) {
                  onTap(value, index);
                },
              );
            },
          );
  }
}
