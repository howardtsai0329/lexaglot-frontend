import 'package:flutter/material.dart';

class MatchingPairsView extends StatefulWidget {
  const MatchingPairsView({super.key});

  @override
  State<MatchingPairsView> createState() => _MatchingPairsViewState();
}

class _MatchingPairsViewState extends State<MatchingPairsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('This will be matching pairs'),
      ),
      body: const Text('help'),
    );
  }
}
