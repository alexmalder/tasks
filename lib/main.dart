import 'package:flutter/material.dart';
import 'package:tasks/screens/tasks_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tasks App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TasksScreen(),
    );
  }
}
