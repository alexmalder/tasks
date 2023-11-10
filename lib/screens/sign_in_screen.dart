import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:videos/core/constants.dart';
import 'package:videos/models/account.dart';
import 'package:videos/services/sign_service.dart';
import 'package:quickalert/quickalert.dart';

class SignInScreen extends StatefulWidget {
  final Account? account;

  const SignInScreen({super.key, this.account});

  @override
  State<SignInScreen> createState() => _SignInScreen();
}

class _SignInScreen extends State<SignInScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Center(child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: usernameController,
            decoration: const InputDecoration(hintText: 'Username'),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(hintText: 'Password'),
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              final isSuccess = SignService.signIn(usernameController.text, passwordController.text);
              isSuccess.then((success) => {
                if (success == false) {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: 'Oops...',
                    text: 'Wrong username or password',
                  )
                } else {
                  usernameController.text = '',
                  passwordController.text = '',
                  context.go(Routes.homeNamedPage),
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.success,
                    text: 'Sign In Completed!',
                  )
                }
              });
            },
            child: const Text('Sign In'),
          ),
        ],
      )),
    );
  }
}