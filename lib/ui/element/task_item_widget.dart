import 'package:flutter/material.dart';
import 'package:tasky/models/task/task_model.dart';
import 'package:tasky/ui/element/checkbox/checkbox_icon_widget.dart';

class TaskItemWidget extends StatefulWidget {
  TaskItemWidget({
    super.key,
    required this.data,
    required this.onComplete,
    required this.onDelete,
    this.onTap,
  });

  TaskModel data;
  final VoidCallback onComplete;
  final VoidCallback onDelete;
  final GestureTapCallback? onTap;

  @override
  State<TaskItemWidget> createState() => _TaskItemWidgetState();
}

class _TaskItemWidgetState extends State<TaskItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Dismissible(
        confirmDismiss: (direction) async {
          if(direction == DismissDirection.startToEnd) {
            widget.onComplete();
          }
          if(direction == DismissDirection.endToStart) {
            widget.onDelete();
            return true;
          }
          return false;
        },
        key: Key(widget.data.uid.toString()),
        background: Container(
          color: Colors.green,
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          ),
        ),
        secondaryBackground: Container(
          color: Colors.red,
          child: const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 12.0,
            bottom: 12.0,
            left: 16.0,
            right: 16.0,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CheckboxIconWidget(
                widget.data.isCompleted,
                isCheckedIcon: Icons.check_box,
                isUncheckedIcon: Icons.check_box_outline_blank,
                size: 24,
                color: widget.data.isCompleted
                    ? const Color(0xff34c759)
                    : widget.data.isPriority == true
                        ? const Color(0xffff3b30)
                        : const Color(0x33000000),
                onPressed: widget.onComplete,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.data.isPriority != null)
                            Icon(
                              widget.data.isPriority == true
                                  ? Icons.priority_high
                                  : Icons.arrow_downward,
                              color: widget.data.isPriority == true
                                  ? const Color(0xffff3b30)
                                  : const Color(0x33000000),
                              size: 16,
                            ),
                          Expanded(
                            child: Text(
                              widget.data.value,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (widget.data.date != null)
                        Text(
                          "${widget.data.date}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                            color: Color(0x4c000000),
                            fontSize: 14,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 12.0,
                ),
                child: Icon(
                  Icons.info_outline,
                  size: 24.0,
                  color: Color(0x4c000000),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
