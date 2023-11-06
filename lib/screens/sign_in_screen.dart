import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:videos/core/constants.dart';
import 'package:videos/models/account.dart';
import 'package:videos/services/sign_service.dart';
import 'package:quickalert/quickalert.dart';

class SignInPage extends StatefulWidget {
  final Account? account;

  const SignInPage({super.key, this.account});

  @override
  State<SignInPage> createState() => _SignInPage();
}

class _SignInPage extends State<SignInPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Map get body {
    final username = usernameController.text;
    final password = passwordController.text;
    return {
      "username": username,
      "password": password,
    };
  }

  Future<void> submitData() async {
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
              final isSuccess = SignService.signIn(body);
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