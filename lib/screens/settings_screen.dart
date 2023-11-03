import 'package:flutter/material.dart';

// @task need sign-in page
// @task need alert when sign-in succeed
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

