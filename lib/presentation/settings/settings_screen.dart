import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Settings',
        style: TextStyle(
            color: Colors.white
        ),
      ),
    );
  }
}

