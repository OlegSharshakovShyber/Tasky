import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tasky/data/models/task_model.dart';
import 'package:tasky/data/providers/task_provider.dart';
import 'package:tasky/features/task/presentation/task_info/widgets/priority_widget.dart';
import 'package:tasky/features/task/presentation/task_info/widgets/sub_title_widget.dart';
import 'package:tasky/features/task/presentation/task_info/widgets/title_widget.dart';

class TaskInfoScreen extends StatefulWidget {
  const TaskInfoScreen({super.key, this.task});

  final TaskModel? task;

  @override
  State<TaskInfoScreen> createState() => _TaskInfoScreenState();
}

class _TaskInfoScreenState extends State<TaskInfoScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  bool? _isPriority;
  String? _date;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _textEditingController.text = widget.task?.value ?? '';
      _isPriority = widget.task?.isPriority;
      _date = widget.task?.date;
    }
  }

  void addTask(TaskModel task) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    taskProvider.addTask(task);
  }

  void updateTask(TaskModel task) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    taskProvider.updateTask(task);
  }

  void deleteTask(int uid) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    taskProvider.deleteTask(uid);
    Navigator.pop(context);
  }

  void _saveTask() {
    final TaskModel task = TaskModel(
      isCompleted: false,
      value: _textEditingController.text,
      isPriority: _isPriority,
      date: _date,
    );

    if (widget.task == null) {
      addTask(task);
    } else {
      updateTask(task);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f6f2),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              elevation: 16,
              pinned: true,
              leading: IconButton(
                icon: const Icon(
                  Icons.close,
                  size: 24,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Row(
                children: <Widget>[
                  const Spacer(),
                  GestureDetector(
                    onTap: _saveTask,
                    child: const Text(
                      'СОХРАНИТЬ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            )
          ];
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.white,
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: _textEditingController,
                    maxLines: null,
                    minLines: 3,
                    decoration: const InputDecoration(
                      hintText: 'Что надо сделать…',
                      hintStyle: TextStyle(
                        color: Color(0x4c000000),
                        fontSize: 16,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: PriorityWidget(
                isPriority: _isPriority,
                newPriorityCallback: (bool? value) {
                  setState(() {
                    _isPriority = value;
                  });
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const TitleWidget(
                        'Сделать до',
                        color: Colors.black,
                      ),
                      _date?.isNotEmpty == true
                          ? SubTitleWidget(
                              _date ?? '',
                              color: const Color(0xff007aff),
                            )
                          : const SizedBox(
                              height: 14,
                            ),
                    ],
                  ),
                  const Spacer(),
                  Switch(
                    value: _date?.isNotEmpty == true,
                    onChanged: (bool value) {
                      if (value) {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        ).then((DateTime? selectedDate) {
                          if (selectedDate != null) {
                            setState(() {
                              _date =
                                  DateFormat('yyyy-MM-dd').format(selectedDate);
                            });
                          }
                        });
                      } else {
                        setState(() {
                          _date = null;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            const Divider(),
            widget.task != null
                ? GestureDetector(
                    onTap: () {
                      final int? uid = widget.task?.uid;
                      if (uid != null) {
                        deleteTask(uid);
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.delete,
                            size: 24,
                            color: Color(0xffff3b30),
                          ),
                          TitleWidget(
                            'Удалить',
                            color: Color(0xffff3b30),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
