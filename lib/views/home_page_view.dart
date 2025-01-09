import 'package:flutter/material.dart';
import 'package:lexaglot/constants/routes.dart';
import 'package:lexaglot/database/logout.dart';
import 'package:lexaglot/enums/menu_action.dart';
import 'package:lexaglot/utilities/dialogs/logout_dialog.dart';
import 'package:lexaglot/views/chat_view.dart';
import 'package:lexaglot/views/dictionary_view.dart';
import 'package:lexaglot/views/settings_view.dart';
import 'package:lexaglot/views/start_menu_view.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  int index = 1;

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
                      await logout();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        loginRoute,
                        (_) => false,
                      );
                    }
                  case MenuAction.settings:
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return const SettingsView();
                      }),
                    );
                }
              },
              itemBuilder: (context) {
                return const [
                  PopupMenuItem<MenuAction>(
                    value: MenuAction.settings,
                    child: Text('Settings'),
                  ),
                  PopupMenuItem<MenuAction>(
                    value: MenuAction.logout,
                    child: Text('Log out'),
                  ),
                ];
              },
            )
          ],
        ),
        body: IndexedStack(
          index: index,
          children: const [
            ChatView(),
            StartMenuView(),
            DictionaryView(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: index,
            onTap: (int newIndex) {
              setState(() {
                index = newIndex;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.forum_rounded,
                ),
                label: "Chat",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.book,
                ),
                label: "Word Bank",
              )
            ]));
  }
}
