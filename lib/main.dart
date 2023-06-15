import 'package:flutter/material.dart';
import 'package:tasky/screens/task_info/task_info_screen.dart';
import 'package:tasky/screens/task_list/task_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasky',
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: const TaskInfoScreen(title: 'Flutter Demo Home Page'),
    );
  }
}
