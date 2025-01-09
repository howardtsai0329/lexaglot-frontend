import 'package:flutter/material.dart';
import 'package:lexaglot/constants/routes.dart';
import 'package:lexaglot/database/login.dart';
import 'package:lexaglot/utilities/dialogs/error_dialog.dart';
import 'dart:developer' as dev;

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> loginUser(String email, String password) async {
    try {
      // Authenticate user and get the JWT token
      String token = await login(email, password);
      await storeToken(token);

      // Check token validity
      if (isTokenExpired(token)) {
        dev.log('Token is expired. Please refresh.');
        throw Exception('Token expired. Please log in again.');
      }

      // Navigate to the start menu on successful login
      Navigator.of(context).pushNamedAndRemoveUntil(
        homePageRoute,
        (route) => false,
      );
    } catch (e) {
      dev.log('Login error: $e');
      await showErrorDialog(context, 'Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _email,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration:
                  const InputDecoration(hintText: "Enter your email here"),
            ),
            TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration:
                  const InputDecoration(hintText: "Enter your password here"),
            ),
            TextButton(
              onPressed: () async {
                final email = _email.text.trim();
                final password = _password.text.trim();
                if (email.isEmpty || password.isEmpty) {
                  await showErrorDialog(
                      context, 'Email and password cannot be empty.');
                  return;
                }
                await loginUser(email, password);
              },
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  registerRoute,
                  (route) => false,
                );
              },
              child: const Text('Not registered yet? Register here!'),
            ),
          ],
        ),
      ),
    );
  }
}
