import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Home',
        style: TextStyle(
          color: Colors.white
        ),
      ),
    );
  }
}
