import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/models/task/task_provider.dart';
import 'package:tasky/screens/task_list/task_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => TaskProvider(),
      child: MaterialApp(
        theme: ThemeData.light(),
        debugShowCheckedModeBanner: false,
        home: const TaskListScreen(),
      ),
    );
  }
}
