class TaskModel {
  int uid;
  bool isCompleted;
  final String value;
  bool? isPriority;
  String? date;

  TaskModel({
    required this.uid,
    required this.isCompleted,
    required this.value,
    this.isPriority,
    this.date,
  });
}
