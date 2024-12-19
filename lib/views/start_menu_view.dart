import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lexaglot/constants/routes.dart';
import 'package:lexaglot/enums/menu_action.dart';
import 'package:lexaglot/utilities/dialogs/logout_dialog.dart';
import 'package:lexaglot/views/matching_pairs_view.dart';

class StartMenuView extends StatelessWidget {
  const StartMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language: '),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(context);
                  if (shouldLogout) {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      loginRoute,
                      (_) => false,
                    );
                  }
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuAction>(
                    value: MenuAction.logout, child: Text('Log out'))
              ];
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (BuildContext context) {
                  return const MatchingPairsView();
                }));
              },
              icon: const Icon(Icons.play_circle),
              color: Colors.lightGreen,
              iconSize: 150.0,
            ),
            const SizedBox(
              height: 50,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.book),
              iconSize: 50,
            )
          ],
        ),
      ),
    );
  }
}
