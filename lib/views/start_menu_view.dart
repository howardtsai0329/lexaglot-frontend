import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lexaglot/constants/routes.dart';
import 'package:lexaglot/enums/menu_action.dart';
import 'package:lexaglot/excercises/general/colored_button.dart.dart';
import 'package:lexaglot/excercises/matching_pairs/matching_pairs_view.dart';
import 'package:lexaglot/utilities/dialogs/logout_dialog.dart';
import 'package:lexaglot/views/chat_view.dart';
import 'package:lexaglot/views/dictionary_view.dart';

class StartMenuView extends StatefulWidget {
  const StartMenuView({super.key});

  @override
  State<StartMenuView> createState() => _StartMenuViewState();
}

class _StartMenuViewState extends State<StartMenuView> {
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Shiro_Anime_HQ.webp',
              height: 400.0,
            ),
            ColoredButton(
              title: 'Learn',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const MatchingPairsView();
                  }),
                );
              },
              backgroundColor: Colors.green,
              textColor: Colors.black,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 100.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const ChatView();
                    },
                  ),
                );
              },
              icon: const Icon(Icons.forum_rounded),
              iconSize: 50,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.home),
              iconSize: 50,
              color: Colors.green,
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const DictionaryView();
                    },
                  ),
                );
              },
              icon: const Icon(Icons.book),
              iconSize: 50,
            ),
          ],
        ),
      ),
    );
  }
}
