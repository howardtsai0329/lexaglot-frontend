import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lexaglot/constants/routes.dart';
import 'package:lexaglot/excercises/matching_pairs/the_matching_pairs_game.dart';
import 'package:lexaglot/firebase_options.dart';
import 'package:lexaglot/views/matching_pairs_view.dart';
import 'package:lexaglot/views/login_view.dart';
import 'package:lexaglot/views/register_view.dart';
import 'package:lexaglot/views/start_menu_view.dart';
import 'package:lexaglot/views/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData.dark(),
    debugShowCheckedModeBanner: false,
    home: const HomePage(),
    routes: {
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegisterView(),
      startMenuRoute: (context) => const StartMenuView(),
      verifyEmailRoute: (context) => const VerifyEmailView(),
      matchingPairsRoute: (context) => const MatchingPairsView(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              if (user.emailVerified) {
                return const TheMatchingPairsGame();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
