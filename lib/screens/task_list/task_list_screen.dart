import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/ui/element/checkbox/visibility_icon_widget.dart';
import 'package:tasky/ui/element/task_item_widget.dart';
import 'package:tasky/ui/element/title/header/sub_title_header_widget.dart';
import 'package:tasky/ui/element/title/header/title_header_widget.dart';
import 'package:tasky/ui/header/header_widget.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  ScrollController? _scrollController;
  bool _lastStatus = true;
  double _height = 140;

  bool _checkedIsVisibleFlag = true;

  final List<TaskModel> itemList = [
    TaskModel(
      uid: 0,
      isCompleted: false,
      value: 'Task 1',
      isPriority: true,
      date: '2023-06-12',
    ),
    TaskModel(
      uid: 1,
      isCompleted: false,
      value: 'Task 1',
      isPriority: true,
      date: '2023-06-12',
    ),
    TaskModel(
      uid: 2,
      isCompleted: false,
      value: 'Task 1',
      isPriority: true,
      date: '2023-06-12',
    ),
    TaskModel(
      uid: 3,
      isCompleted: true,
      value: 'Task 2',
    ),
    TaskModel(
      uid: 4,
      isCompleted: true,
      value: 'Task 2',
    ),
    TaskModel(
      uid: 5,
      isCompleted: true,
      value: 'Task 2',
    ),
    TaskModel(
      uid: 6,
      isCompleted: true,
      value: 'Task 2',
    ),
    TaskModel(
      uid: 7,
      isCompleted: true,
      value: 'Task 2',
    ),
    TaskModel(
      uid: 8,
      isCompleted: true,
      value: 'Task 2',
    ),
    TaskModel(
      uid: 9,
      value:
          "Фьючерсный контракт — это договор между покупателем и продавцом о покупке/продаже какого-то актива в будущем. Стороны заранее оговаривают, через какой срок и по какой цене состоится сделка.\n Например, сейчас одна акция «Лукойла» стоит около 5700 рублей. Фьючерс на акции «Лукойла» — это, например, договор между покупателем и продавцом о том, что покупатель купит акции «Лукойла» у продавца по цене 5700 рублей через 3 месяца. При этом не важно, какая цена будет у акций через 3 месяца: цена сделки между покупателем и продавцом все равно останется 5700 рублей. Если реальная цена акции через три месяца не останется прежней, одна из сторон в любом случае понесет убытки.",
      isCompleted: Random().nextBool(),
      isPriority: Random().nextBool() ? Random().nextBool() : null,
      date:
          "Фьючерсный контракт — это договор между покупателем и продавцом о покупке/продаже какого-то актива в будущем. Стороны заранее оговаривают, через какой срок и по какой цене состоится сделка.\n Например, сейчас одна акция «Лукойла» стоит около 5700 рублей. Фьючерс на акции «Лукойла» — это, например, договор между покупателем и продавцом о том, что покупатель купит акции «Лукойла» у продавца по цене 5700 рублей через 3 месяца. При этом не важно, какая цена будет у акций через 3 месяца: цена сделки между покупателем и продавцом все равно останется 5700 рублей. Если реальная цена акции через три месяца не останется прежней, одна из сторон в любом случае понесет убытки.",
    ),
  ];

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

  void updateCompleteStateItem(TaskModel updateTaskItem) {
    var index =
        itemList.indexWhere((element) => element.uid == updateTaskItem.uid);
    setState(() {
      updateTaskItem.isCompleted = !updateTaskItem.isCompleted;
      itemList[index] = updateTaskItem;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      "Мои дела",
                    )
                  : null,
              background: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 60.0,
                      bottom: 26.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        const TitleHeaderWidget(
                          "Мои дела",
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        SubTitleHeaderWidget(
                          "Выполнено - ${itemList.where((element) => element.isCompleted).length}",
                        ),
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
                  ? [
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
                  children: itemList.where((element) {
                    if (_checkedIsVisibleFlag) {
                      return true;
                    } else {
                      return !element.isCompleted;
                    }
                  }).map((item) {
                    return TaskItemWidget(
                      data: item,
                      onComplete: () {
                        updateCompleteStateItem(item);
                      },
                      onDelete: () {
                        itemList.remove(item);
                      },
                    );
                  }).toList(),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
