import 'package:flutter/material.dart';
import 'package:lexaglot/database/cached_exercises.dart';

class ExerciseStackPage extends StatefulWidget {
  const ExerciseStackPage({super.key});

  @override
  State<ExerciseStackPage> createState() => _ExerciseStackPageState();
}

class _ExerciseStackPageState extends State<ExerciseStackPage> {
  final List<Widget Function(BuildContext, VoidCallback)> _views = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _generateViews();
  }

  Future<void> _generateViews() async {
    setState(() {
      _isLoading = true;
    });

    final newViews = await fetchCachedExercise(context);

    if (mounted) {
      setState(() {
        _views.addAll(newViews);
        _isLoading = false;
      });
    }
  }

  void _navigateToNext(int currentIndex) {
    if (currentIndex < _views.length - 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => _views[currentIndex + 1](context, () {
            _navigateToNext(currentIndex + 1);
          }),
        ),
      );
    } else {
      // Fetch more views and navigate to the next one
      _generateViews().then((_) {
        if (mounted && _views.length > currentIndex + 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => _views[currentIndex + 1](context, () {
                _navigateToNext(currentIndex + 1);
              }),
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading && _views.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return _views.isNotEmpty
        ? _views[0](
            context, () => _navigateToNext(0)) // Start from the first view
        : const Scaffold(
            body: Center(
              child: Text('No views available'),
            ),
          );
  }
}
