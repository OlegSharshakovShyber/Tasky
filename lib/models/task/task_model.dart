class TaskModel {
  int uid;
  bool isCompleted;
  String value;
  bool? isPriority;
  String? date;

  TaskModel({
    this.uid = -1,
    required this.isCompleted,
    required this.value,
    this.isPriority,
    this.date,
  });
}
