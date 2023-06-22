import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'task_model.dart';

class TaskProvider extends ChangeNotifier {
  int _nextUid = 1;
  final List<TaskModel> _tasks = <TaskModel>[];

  List<TaskModel> get tasks => _tasks;

  void addTask(TaskModel task) {
    final TaskModel taskWithUid = TaskModel(
      uid: _nextUid,
      isCompleted: task.isCompleted,
      value: task.value,
      isPriority: task.isPriority,
      date: task.date,
    );
    _tasks.add(taskWithUid);
    _nextUid++;
    notifyListeners();
  }

  void updateTask(TaskModel task) {
    final int index = _tasks.indexWhere((TaskModel t) => t.uid == task.uid);
    if (index != -1) {
      _tasks[index] = task;
      notifyListeners();
    }
  }

  void deleteTask(int uid) {
    _tasks.removeWhere((TaskModel task) => task.uid == uid);
    notifyListeners();
  }
}

TaskProvider taskProvider(BuildContext context) =>
    Provider.of<TaskProvider>(context, listen: false);
