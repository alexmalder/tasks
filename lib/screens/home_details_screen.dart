import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:videos/models/artifact.dart';
import 'package:videos/services/artifact_service.dart';

class HomeDetailsScreen extends StatefulWidget {
  const HomeDetailsScreen({super.key});

  @override
  State<HomeDetailsScreen> createState() => _HomeDetailsScreen();
}

// @task need id required parameter
class _HomeDetailsScreen extends State<HomeDetailsScreen> {
  late Future<Artifact> futureArtifact;

  @override
  void initState() {
    super.initState();
    futureArtifact = ArtifactService.fetchOne();
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