import 'package:flutter/material.dart';
import 'package:lexaglot/excercises/general/colored_button.dart.dart';
import 'package:lexaglot/excercises/matching_pairs/matching_pairs_view.dart';

class StartMenuView extends StatefulWidget {
  const StartMenuView({super.key});

  @override
  State<StartMenuView> createState() => _StartMenuViewState();
}

class _StartMenuViewState extends State<StartMenuView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
