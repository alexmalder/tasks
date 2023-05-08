import 'package:flutter/material.dart';
import 'package:videos/models/task.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<Task> tasksList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tasks App'), actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.add),
        ),
      ]),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
            child: Chip(
              label: Text(
                'Tasks:',
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: tasksList.length,
              itemBuilder: (context, index) {
                var task = tasksList[index];
                return ListTile(
                  title: Text(task.title),
                  trailing: Checkbox(
                    value: task.isDone,
                    onChanged: (value) {},
                  ),
                );
              },
            )
          )

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
