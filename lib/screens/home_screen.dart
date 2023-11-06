import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:videos/models/artifact.dart';
import 'package:videos/services/artifact_service.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Artifact> artifacts = [];
  late Artifact artifact;
  bool isLoading = true;

  Future<void> fetchArtifacts() async {
    Sentry.captureMessage("Artifacts loaded");
    final response = await ArtifactService.fetch();
    setState(() {
      artifacts = response;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchArtifacts();
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
          onRefresh: fetchArtifacts,
          child: Visibility(
            visible: artifacts.isNotEmpty,
            replacement: Center(
                child: Text(
                  'No todo items',
                  style: Theme.of(context).textTheme.headlineSmall,
                )),
            child: ListView.builder(
              itemCount: artifacts.length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final item = artifacts[index];
                final id = artifacts[index].id;
                // int id = item['ID'] as int;
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(child: Text('${index + 1}')),
                    title: Text(item.title),
                    subtitle: Text(item.link),
                    trailing: PopupMenuButton(
                      onSelected: (result){
                        switch(result){
                          case 0:
                            context.go("/home/$id")
                          ; break;
                          case 1: context.go('/home/123'); break;
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                            value: 0,
                            child: Text("Edit")
                        ),
                        const PopupMenuItem(
                            value: 1,
                            child: Text("Delete")
                        )
                      ],
                      icon: const Icon(
                        Icons.settings,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        child: const Center(child: CircularProgressIndicator()),
      ),
      );
  }
}
