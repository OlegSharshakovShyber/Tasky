import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/data/models/task_model.dart';
import 'package:tasky/data/providers/task_provider.dart';
import 'package:tasky/features/task/presentation/task_info/task_info_screen.dart';
import 'package:tasky/features/task/presentation/task_list/widgets/visibility_icon_widget.dart';
import 'package:tasky/features/task/presentation/task_list/widgets/task_item_widget.dart';
import 'package:tasky/shared/components/sub_title_header_widget.dart';
import 'package:tasky/shared/components/title_header_widget.dart';
import 'package:tasky/features/task/presentation/task_list/widgets/header_widget.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  ScrollController? _scrollController;
  bool _lastStatus = true;
  final double _height = 140;

  bool _checkedIsVisibleFlag = true;

  void _scrollListener() {
    if (_isShrink != _lastStatus) {
      setState(() {
        _lastStatus = _isShrink;
      });
    }
  }

  bool get _isShrink {
    return _scrollController != null &&
        _scrollController!.hasClients &&
        _scrollController!.offset > (_height - kToolbarHeight);
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_scrollListener);
    _scrollController?.dispose();
    super.dispose();
  }

  void switchVisibilityFlag() {
    setState(() {
      _checkedIsVisibleFlag = !_checkedIsVisibleFlag;
    });
  }

  void _openCreateTaskScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const TaskInfoScreen(),
      ),
    );
  }

  void _openEditTaskScreen(TaskModel task) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => TaskInfoScreen(
          task: task,
        ),
      ),
    );
  }

  void deleteTask(int uid) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    taskProvider.deleteTask(uid);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (BuildContext context, TaskProvider taskProvider, _) {
        final List<TaskModel> itemList = taskProvider.tasks;

        void updateCompleteStateItem(TaskModel updateTaskItem) {
          final index = itemList
              .indexWhere((element) => element.uid == updateTaskItem.uid);
          setState(() {
            updateTaskItem.isCompleted = !updateTaskItem.isCompleted;
            itemList[index] = updateTaskItem;
          });
        }

        final completedCount = itemList.where((el) => el.isCompleted).length;

        return Scaffold(
          backgroundColor: const Color(0xfff7f6f2),
          body: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                HeaderWidget(
                  expandedHeight: _height,
                  title: _isShrink
                      ? const TitleHeaderWidget(
                          'Мои дела',
                        )
                      : null,
                  background: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 60.0,
                          bottom: 26.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Spacer(),
                            const TitleHeaderWidget(
                              'Мои дела',
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            SubTitleHeaderWidget('Выполнено - $completedCount'),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 24,
                          bottom: 16.0,
                        ),
                        child: VisibilityIconWidget(
                          _checkedIsVisibleFlag,
                          onPressed: switchVisibilityFlag,
                        ),
                      ),
                    ],
                  ),
                  actions: _isShrink
                      ? <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 16,
                              right: 24,
                              top: 16,
                            ),
                            child: VisibilityIconWidget(
                              _checkedIsVisibleFlag,
                              onPressed: switchVisibilityFlag,
                            ),
                          ),
                        ]
                      : null,
                )
              ];
            },
            body: ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: Colors.white,
                  elevation: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Column(
                      children: itemList.where((TaskModel element) {
                        if (_checkedIsVisibleFlag) {
                          return true;
                        } else {
                          return !element.isCompleted;
                        }
                      }).map((TaskModel item) {
                        return TaskItemWidget(
                          data: item,
                          onComplete: () {
                            updateCompleteStateItem(item);
                          },
                          onDelete: () {
                            deleteTask(item.uid);
                          },
                          onTap: () {
                            _openEditTaskScreen(item);
                          },
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _openCreateTaskScreen,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
