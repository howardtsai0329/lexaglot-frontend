import 'package:flutter/material.dart';
import 'package:lexaglot/excercises/general/colored_button.dart';
import 'package:lexaglot/views/next_exercise_view.dart';

class StartMenuView extends StatefulWidget {
  const StartMenuView({super.key});

  @override
  State<StartMenuView> createState() => _StartMenuViewState();
}

class _StartMenuViewState extends State<StartMenuView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(
      const AssetImage('assets/images/Megumin.png'),
      context,
    );
  }

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
                // Navigator.of(context).push(
                //   MaterialPageRoute(builder: (BuildContext context) {
                //     return const Scaffold();
                //   }),
                // );
              },
              textColor: Colors.black,
            ),
            ColoredButton(
              title: 'Currently Developing',
              onPressed: () async {
                try {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => NextExerciseScreen()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: $e'),
                    ),
                  );
                }
              },
              textColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
