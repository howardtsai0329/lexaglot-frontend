import 'package:flutter/material.dart';
import 'package:lexaglot/views/start_menu_view.dart';

class TheMatchingPairsGame extends StatelessWidget {
  const TheMatchingPairsGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const StartMenuView(),
      title: 'I have no idea what this page does',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
    );
  }
}
