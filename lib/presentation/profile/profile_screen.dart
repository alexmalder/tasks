import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:videos/core/utils/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.go("profile?");
      },
      child: const Text('Go to song 2'),
    );
  }
}
