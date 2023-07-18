
import 'package:flutter/material.dart';
import 'package:videos/services/artifact_service.dart';
import 'package:videos/utils/snackbar_helper.dart';

class AddTodoPage extends StatefulWidget {
  final Map? todo;
  const AddTodoPage({super.key, this.todo});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      final title = todo['title'];
      final description = todo['description'];
      titleController.text = title;
      descriptionController.text = description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Todo' : 'Add Todo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: 'Title'),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(hintText: 'Description'),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: isEdit ? updateData : submitData,
            child: Text(isEdit ? 'Update' : 'Submit'),
          ),
        ],
      ),
    );
  }

  Future<void> navigateToTasksPage() async {
    Navigator.pop(context);
  }

  Future<void> updateData() async {
    final todo = widget.todo;
    if (todo == null) {
      return;
    }
    final id = todo[0];
    //final isCompleted = todo['is_completed'];
    final isSuccess = await ArtifactService.updateArtifact(id, body);

    if (isSuccess) {
      // ignore: use_build_context_synchronously
      showSuccessMessage(context, message: "Updation success");
      await navigateToTasksPage();
    } else {
      // ignore: use_build_context_synchronously
      showErrorMessage(context, message: "Updation failed");
    }
  }

  Future<void> submitData() async {
    final isSuccess = await ArtifactService.addArtifact(body);

    if (isSuccess) {
      titleController.text = '';
      descriptionController.text = '';
      // ignore: use_build_context_synchronously
      showSuccessMessage(context, message: "CreationSuccess");
      await navigateToTasksPage();
    } else {
      // ignore: use_build_context_synchronously
      showErrorMessage(context, message: "Creation failed");
    }
  }

  Map get body {
    final title = titleController.text;
    final description = descriptionController.text;
    return {
      "title": title,
      "description": description,
      "is_completed": false,
    };
  }
}
