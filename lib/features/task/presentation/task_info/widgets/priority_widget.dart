import 'package:flutter/material.dart';
import 'package:tasky/features/task/presentation/task_info/widgets/sub_title_widget.dart';
import 'package:tasky/features/task/presentation/task_info/widgets/title_widget.dart';

class PriorityWidget extends StatefulWidget {
  const PriorityWidget({
    Key? key,
    required this.newPriorityCallback,
    required this.isPriority,
  }) : super(key: key);

  final bool? isPriority;
  final Function(bool?) newPriorityCallback;

  @override
  State<PriorityWidget> createState() => _PriorityWidgetState();
}

class _PriorityWidgetState extends State<PriorityWidget> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<bool?>(
      itemBuilder: (BuildContext context) => <PopupMenuEntry<bool?>>[
        PopupMenuItem<bool?>(
          value: null,
          child: ListTile(
            title: const SubTitleWidget(
              'Нет',
              color: Colors.black,
            ),
            onTap: () {
              widget.newPriorityCallback(null);
              Navigator.pop(context);
            },
          ),
        ),
        PopupMenuItem<bool?>(
          value: false,
          child: ListTile(
            title: const Row(
              children: <Widget>[
                Icon(
                  Icons.arrow_downward,
                  color: Color(0x33000000),
                  size: 16,
                ),
                SubTitleWidget(
                  'Низкий',
                  color: Colors.black,
                ),
              ],
            ),
            onTap: () {
              widget.newPriorityCallback(false);
              Navigator.pop(context);
            },
          ),
        ),
        PopupMenuItem<bool?>(
          value: true,
          child: ListTile(
            title: const Row(
              children: <Widget>[
                Icon(
                  Icons.priority_high,
                  color: Color(0xffff3b30),
                  size: 16,
                ),
                SubTitleWidget(
                  'Высокий',
                  color: Color(0xffff3b30),
                ),
              ],
            ),
            onTap: () {
              widget.newPriorityCallback(true);
              Navigator.pop(context);
            },
          ),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const TitleWidget(
            'Важность',
            color: Colors.black,
          ),
          widget.isPriority == null
              ? const SubTitleWidget(
            'Нет',
            color: Color(0x4c000000),
          )
              : Row(
            children: <Widget>[
              Icon(
                widget.isPriority == true
                    ? Icons.priority_high
                    : Icons.arrow_downward,
                color: widget.isPriority == true
                    ? const Color(0xffff3b30)
                    : const Color(0x33000000),
                size: 16,
              ),
              SubTitleWidget(
                widget.isPriority == true ? 'Высокий' : 'Низкий',
                color: widget.isPriority == true
                    ? const Color(0xffff3b30)
                    : const Color(0x33000000),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
