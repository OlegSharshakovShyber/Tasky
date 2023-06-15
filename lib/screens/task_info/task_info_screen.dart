import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/ui/element/priority/priority_widget.dart';
import 'package:tasky/ui/element/title/content/sub_title_widget.dart';
import 'package:tasky/ui/element/title/content/title_widget.dart';

class TaskInfoScreen extends StatefulWidget {
  const TaskInfoScreen({super.key});

  @override
  State<TaskInfoScreen> createState() => _TaskInfoScreenState();
}

class _TaskInfoScreenState extends State<TaskInfoScreen> {
  final TextEditingController textEditingController = TextEditingController();

  var task = TaskModel(
    uid: 0,
    isCompleted: false,
    value: 'Task 1',
    isPriority: true,
    date: null,
  );

  @override
  Widget build(BuildContext context) {
    textEditingController.text = task.value;
    return Scaffold(
      backgroundColor: const Color(0xfff7f6f2),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            const SliverAppBar(
              elevation: 16,
              pinned: true,
              title: Row(
                children: [
                  Icon(
                    Icons.close,
                    size: 24,
                    color: Colors.black,
                  ),
                  Spacer(),
                  Text(
                    "СОХРАНИТЬ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            )
          ];
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    controller: textEditingController,
                    onChanged: (value) {
                      task.value = value;
                    },
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
                isPriority: task.isPriority,
                newPriorityCallback: (value) {
                  setState(() {
                    task.isPriority = value;
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
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TitleWidget(
                        "Сделать до",
                        color: Colors.black,
                      ),
                      task.date?.isNotEmpty == true
                          ? SubTitleWidget(
                              task.date.toString(),
                              color: const Color(0xff007aff),
                            )
                          : const SizedBox(
                              height: 14,
                            ),
                    ],
                  ),
                  const Spacer(),
                  Switch(
                    value: task.date?.isNotEmpty == true,
                    onChanged: (value) {
                      if (value) {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        ).then((selectedDate) {
                          if (selectedDate != null) {
                            setState(() {
                              task.date =
                                  DateFormat('yyyy-MM-dd').format(selectedDate);
                            });
                          }
                        });
                      } else {
                        setState(() {
                          task.date = null;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    Icons.delete,
                    size: 24,
                    color: Color(0xffff3b30),
                  ),
                  TitleWidget(
                    "Удалить",
                    color: Color(0xffff3b30),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
