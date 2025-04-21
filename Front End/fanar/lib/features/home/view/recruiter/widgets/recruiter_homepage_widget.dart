import 'package:flutter/material.dart';

class RecruiterHomepageWidget extends StatelessWidget {
  const RecruiterHomepageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Text(
          'صفحة مكتشف المواهب',
          style: TextStyle(
            fontSize: 26.0,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ],
    );
  }
}
