import 'package:flutter/material.dart';
import 'package:videos/screens/add_page.dart';
import 'package:videos/services/sin_service.dart';
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
    fetchSin();
    //fetchSins();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Global Sins'),
      ),
      body: Visibility(
        visible: isLoading,
        replacement: RefreshIndicator(
          onRefresh: fetchSin,
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
                final item = items[index] as List;
                print(item);
                String id;
                if (item.isEmpty) {
                  id = "";
                } else {
                  id = item[0] as String;
                }
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(child: Text('${index + 1}')),
                    title: Text(item[1]),
                    subtitle: Text(item[2]),
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
        label: const Text('Add Sin'),
      ), //FloatingActionButton.extended
    ); // Scaffold
  }

  Future<void> navigateToEditPage(List item) async {
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(todo: item),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchSin();
  }

  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(
      builder: (context) => const AddTodoPage(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchSin();
  }

  Future<void> deleteById(String id) async {
    final isSuccess = await SinService.deleteById(id);
    if (isSuccess) {
      final filtered = items.where((element) => element[0] != id).toList();
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

  Future<void> fetchSin() async {
    final response = await SinService.fetchSins();
    if (response != null) {
      setState(() {
        items = response[0];
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
