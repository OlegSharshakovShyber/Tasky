import 'package:flutter/material.dart';
import 'package:tasky/features/task/presentation/task_info/widgets/sub_title_widget.dart';
import 'package:tasky/features/task/presentation/task_info/widgets/title_widget.dart';

class PriorityWidget extends StatefulWidget {
  const PriorityWidget({
    super.key,
    required this.newPriorityCallback,
    required this.isPriority,
  });

  final bool? isPriority;
  final Function(bool?) newPriorityCallback;

  @override
  State<PriorityWidget> createState() => _PriorityWidgetState();
}

class _PriorityWidgetState extends State<PriorityWidget> {
  bool isMenuOpen = false;

  void toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isMenuOpen
        ? Card(
            elevation: 4,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: const SubTitleWidget(
                    'Нет',
                    color: Colors.black,
                  ),
                  onTap: () => {toggleMenu(), widget.newPriorityCallback(null)},
                ),
                ListTile(
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
                  onTap: () =>
                      <void>{toggleMenu(), widget.newPriorityCallback(false)},
                ),
                ListTile(
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
                  onTap: () => {toggleMenu(), widget.newPriorityCallback(true)},
                ),
              ],
            ),
          )
        : GestureDetector(
            onTap: toggleMenu,
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
