import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky_app/core/enums/task_item_actions_enum.dart';
import 'package:tasky_app/core/services/preference_manager.dart';
import 'package:tasky_app/core/theme/theme_controller.dart';
import 'package:tasky_app/core/widgets/custom_check_box.dart';
import 'package:tasky_app/core/widgets/custom_text_form_filed.dart';
import 'package:tasky_app/models/task_model.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
    required this.model,
    required this.onChanged,
    required this.onDelete,
    required this.onEdit,
  });

  final TaskModel model;
  final void Function(bool?) onChanged;
  final void Function(int?) onDelete;
  final Function onEdit ;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ThemeController.isDark()
              ? Colors.transparent
              : Color(0xffD1DAD6),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 8),

          CustomCheckBox(
            onChanged: (bool? value) => onChanged(value),
            value: model.isCompleted,
          ),

          SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  maxLines: 1,
                  model.taskName,
                  style: model.isCompleted
                      ? Theme.of(context).textTheme.titleLarge
                      : Theme.of(context).textTheme.titleMedium,
                ),
                if (model.taskDescription.isNotEmpty) ...[
                  SizedBox(height: 4),
                  Text(
                    maxLines: 1,
                    model.taskDescription,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: model.isCompleted
                          ? Color(0xff808080)
                          : Color(0xffC6C6C6),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(width: 8),

          PopupMenuButton<TaskItemActionsEnum>(
            icon: Icon(
              Icons.more_vert,
              color: ThemeController.isDark()
                  ? (model.isCompleted ? Color(0xff808080) : Color(0xffC6C6C6))
                  : (model.isCompleted ? Color(0xff6A6A6A) : Color(0xff3A4640)),
            ),

            onSelected: (value) async {
              switch (value) {
                case TaskItemActionsEnum.markAsDone:
                  onChanged(!model.isCompleted);
                case TaskItemActionsEnum.edit:
                  final result = await _showSheetButton(context, model);
                  if(result == true)
                  {
                    onEdit();
                  }
                case TaskItemActionsEnum.delete:
                  await _showDeleteDialog(context);
              }
            },
            itemBuilder: (context) => TaskItemActionsEnum.values.map((e) {
              return PopupMenuItem(value: e, child: Text(e.name));
            }).toList(),
          ),
        ],
      ),
    );
  }

  Future<String?> _showDeleteDialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Delete Item'),
          content: const Text('Are you sure you want to delete this item?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // close dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onDelete(model.id);
                Navigator.of(dialogContext).pop(); // close dialog
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _showSheetButton(BuildContext context, TaskModel model) {
    final taskNameController = TextEditingController(text: model.taskName);
    final taskDescriptionController = TextEditingController(
      text: model.taskDescription,
    );
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    bool isHighPriority = model.isHighPriority;
    return showModalBottomSheet<bool>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, void Function(void Function()) setSheetState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFormFiled(
                      controller: taskNameController,
                      hintText: 'Finish UI design for login screen',
                      title: 'Task Name',
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a task name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 28),
                    CustomTextFormFiled(
                      maxLines: 5,
                      controller: taskDescriptionController,
                      hintText:
                          'Finish onboarding UI and hand off to devs by Thursday.',
                      title: 'Task Description',
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'High Priority',
                          style: TextStyle(
                            color: Color(0xffFFFCFC),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Switch(
                          value: isHighPriority,
                          onChanged: (value) {
                            setSheetState(() {
                              isHighPriority = value;
                            });
                          },
                        ),
                      ],
                    ),
                    Spacer(),
                    ElevatedButton.icon(
                      onPressed: () async {
                        if (formKey.currentState?.validate() ?? false) {
                          final taskJson = PreferenceManager().getString(
                            'tasks',
                          );

                          List<dynamic> taskList = [];
                          if (taskJson != null) {
                            taskList = jsonDecode(taskJson) as List<dynamic>;
                          }
                          final TaskModel newTask = TaskModel(
                            id: model.id,
                            taskName: taskNameController.text,
                            taskDescription: taskDescriptionController.text,
                            isHighPriority: isHighPriority,
                            isCompleted: model.isCompleted,
                          );

                          final int index = taskList.indexWhere(
                            (e) => e['id'] == model.id,
                          );

                          taskList[index] = newTask.toMap();
                          final taskEncoded = jsonEncode(taskList);

                          await PreferenceManager().setString(
                            'tasks',
                            taskEncoded,
                          );

                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop(true);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(MediaQuery.of(context).size.width, 40),

                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      icon: Icon(Icons.edit),
                      label: Text('Edit Task'),
                    ),

                    SizedBox(height: 32),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
