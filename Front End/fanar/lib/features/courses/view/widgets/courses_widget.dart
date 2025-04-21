import 'package:flutter/material.dart';

class CoursesWidget extends StatelessWidget {
  const CoursesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Courses',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 18.0,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
