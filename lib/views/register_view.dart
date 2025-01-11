import 'package:flutter/material.dart';
import 'package:lexaglot/constants/routes.dart';
import 'package:lexaglot/database/register.dart';
import 'package:lexaglot/utilities/dialogs/error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _username;
  late final TextEditingController _fullName;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _username = TextEditingController();
    _fullName = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _username.dispose();
    _fullName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _username,
              enableSuggestions: false,
              autocorrect: false,
              decoration:
                  const InputDecoration(hintText: " Enter your username here"),
            ),
            TextField(
              controller: _fullName,
              enableSuggestions: false,
              autocorrect: false,
              decoration:
                  const InputDecoration(hintText: " Enter your full name here"),
            ),
            TextField(
              controller: _email,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration:
                  const InputDecoration(hintText: " Enter your email here"),
            ),
            TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration:
                  const InputDecoration(hintText: " Enter your password here"),
            ),
            TextButton(
              onPressed: () async {
                final username = _username.text.trim();
                final fullName = _fullName.text.trim();
                final email = _email.text.trim();
                final password = _password.text.trim();

                try {
                  // Register the user using the custom database API
                  await register(username, password, email, fullName);

                  // Navigate to the home page after auto-login
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    homePageRoute, 
                    (route) => false,
                  );
                } catch (e) {
                  // Show error dialog on failure
                  await showErrorDialog(
                    context,
                    'Registration failed: $e',
                  );
                }
              },
              child: const Text('Register'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  loginRoute, // Navigate to the login page
                  (route) => false,
                );
              },
              child: const Text('Already registered? Login here'),
            ),
          ],
        ),
      ),
    );
  }
}
