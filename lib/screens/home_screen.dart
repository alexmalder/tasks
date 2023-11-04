import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:videos/models/artifact.dart';
import 'package:videos/services/artifact_service.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// @task need render list[widget]
// @task need render single item by id[routing]
class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Artifact>> futureArtifact;

  @override
  void initState() {
    super.initState();
    futureArtifact = ArtifactService.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(),
      );
  }
}
