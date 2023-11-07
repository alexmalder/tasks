import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:videos/models/artifact.dart';
import 'package:videos/services/artifact_service.dart';

class HomeDetailsScreen extends StatefulWidget {
  final String? id;
  const HomeDetailsScreen({super.key, this.id});

  @override
  // ignore: no_logic_in_create_state
  State<HomeDetailsScreen> createState() => _HomeDetailsScreen(id!);
}

class _HomeDetailsScreen extends State<HomeDetailsScreen> {
  _HomeDetailsScreen(this.id);
  late String id;
  late Future<Artifact> futureArtifact;

  @override
  void initState() {
    super.initState();
    futureArtifact = ArtifactService.fetchOne(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetch Data Example'),
      ),
      body: Center(
        child: FutureBuilder<Artifact>(
          future: futureArtifact,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.title);
            } else if (snapshot.hasError) {
              Sentry.captureMessage(snapshot.error.toString());
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}