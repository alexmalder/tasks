import 'package:flutter/material.dart';
import 'package:videos/unused/add_page.dart';
import 'package:videos/services/artifact_service.dart';
import 'package:videos/utils/snackbar_helper.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  bool isLoading = true;
  List items = [];

  @override
  void initState() {
    super.initState();
    fetchArtifact();
    //fetchArtifacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Global Artifacts'),
      ),
      body: Visibility(
        visible: isLoading,
        replacement: RefreshIndicator(
          onRefresh: fetchArtifact,
          child: Visibility(
            visible: items.isNotEmpty,
            replacement: Center(
                child: Text(
              'No todo items',
              style: Theme.of(context).textTheme.headlineSmall,
            )),
            child: ListView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final item = items[index] as Map;
                int id = item['ID'] as int;
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(child: Text('${index + 1}')),
                    title: Text(item['title']),
                    subtitle: Text(item['description']),
                    trailing: PopupMenuButton(onSelected: (value) {
                      if (value == "edit") {
                        navigateToEditPage(item);
                      } else if (value == "delete") {
                        // delete and remove the item
                        deleteById(id);
                      }
                    }, itemBuilder: (context) {
                      return [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Text('Edit'),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Text('Delete'),
                        ),
                      ];
                    }),
                  ),
                );
              },
            ),
          ),
        ),
        child: const Center(child: CircularProgressIndicator()),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddPage,
        label: const Text('Add Artifact'),
      ), //FloatingActionButton.extended
    ); // Scaffold
  }

  Future<void> navigateToEditPage(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(todo: item),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchArtifact();
  }

  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(
      builder: (context) => const AddTodoPage(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchArtifact();
  }

  Future<void> deleteById(int id) async {
    final isSuccess = await ArtifactService.deleteById(id);
    if (isSuccess) {
      final filtered = items.where((element) => element['ID'] != id).toList();
      setState(() {
        items = filtered;
      });
      // ignore: use_build_context_synchronously
      showSuccessMessage(context, message: 'Deletion success');
    } else {
      // ignore: use_build_context_synchronously
      showErrorMessage(context, message: 'Deletion failed');
    }
  }

  Future<void> fetchArtifact() async {
    final response = await ArtifactService.fetchArtifacts();
    if (response != null) {
      setState(() {
        items = response;
        //if (response.isNotEmpty) { } else { items = []; }
      });
    } else {
      // ignore: use_build_context_synchronously
      showErrorMessage(context, message: 'Something went wrong');
    }
    setState(() {
      isLoading = false;
    });
  }

}
