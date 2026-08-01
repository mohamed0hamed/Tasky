
class TaskModel {
  final int id ;
  final String taskName;
  final String taskDescription;
  final bool isHighPriority;
  bool isCompleted;

  TaskModel({
    required this.id ,
    required this.taskName,
    required this.taskDescription,
    required this.isHighPriority,
    this.isCompleted = false,
    
  });

  factory TaskModel.fromJson(Map<String, dynamic> json)
  {
    return TaskModel(
      id : json['id'],
      taskName: json['taskName'] ,
      taskDescription: json['taskDescription'] ,
      isHighPriority: json['isHighPriority'] ,
      isCompleted: json['isCompleted'] ?? false, 
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'taskName': taskName,
      'taskDescription': taskDescription,
      'isHighPriority': isHighPriority,
      'isCompleted': isCompleted,
    };
  }
    
  }




 