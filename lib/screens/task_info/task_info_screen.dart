import 'package:flutter/material.dart';
import 'package:tasky/ui/element/title/content/sub_title_widget.dart';
import 'package:tasky/ui/element/title/content/title_widget.dart';

class TaskInfoScreen extends StatefulWidget {
  const TaskInfoScreen({super.key, required this.title});

  final String title;

  @override
  State<TaskInfoScreen> createState() => _TaskInfoScreenState();
}

class _TaskInfoScreenState extends State<TaskInfoScreen> {
  ScrollController? _scrollController;
  bool _lastStatus = true;
  double _height = 140;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f6f2),
      body: NestedScrollView(
        controller: _scrollController,
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
                      color: Color(0xff007aff),
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
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleWidget(
                    "Важность",
                    color: Colors.black,
                  ),
                  SubTitleWidget(
                    "Нет",
                    color: Color(0x4c000000),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleWidget(
                        "Сделать до",
                        color: Colors.black,
                      ),
                      SubTitleWidget(
                        "2 июня 2021",
                        color: Color(0xff007aff),
                      ),
                    ],
                  ),
                  Spacer(),
                  Switch(value: false, onChanged: null)
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
