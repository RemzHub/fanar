import 'package:flutter/material.dart';

class TestStepperIndicator extends StatelessWidget {
  final int index;

  const TestStepperIndicator({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 8.0,
      children: [
        Container(
          height: index == 1 ? 40 : 30,
          width: index == 1 ? 40 : 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                index == 1
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
            border:
                index == 1
                    ? null
                    : Border.all(color: Theme.of(context).colorScheme.primary),
          ),
          child: Center(
            child: Text(
              '1',
              style: TextStyle(
                color: index == 1
                    ? Colors.white : Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
              ),
            ),
          ),
        ),
        Container(
          height: index == 2 ? 40 : 30,
          width: index == 2 ? 40 : 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                index == 2
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
            border:
                index == 2
                    ? null
                    : Border.all(color: Theme.of(context).colorScheme.primary),
          ),
          child: Center(
            child: Text(
              '2',
              style: TextStyle(
                color: index == 2
                    ? Colors.white : Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
              ),
            ),
          ),
        ),
        Container(
          height: index == 3 ? 40 : 30,
          width: index == 3 ? 40 : 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                index == 3
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
            border:
                index == 3
                    ? null
                    : Border.all(color: Theme.of(context).colorScheme.primary),
          ),
          child: Center(
            child: Text(
              '3',
              style: TextStyle(
                color: index == 3
                    ? Colors.white : Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
              ),
            ),
          ),
        ),
        Container(
          height: index == 4 ? 40 : 30,
          width: index == 4 ? 40 : 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                index == 4
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
            border:
                index == 4
                    ? null
                    : Border.all(color: Theme.of(context).colorScheme.primary),
          ),
          child: Center(
            child: Text(
              '4',
              style: TextStyle(
                color: index == 4
                    ? Colors.white : Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
              ),
            ),
          ),
        ),
        Container(
          height: index == 5 ? 40 : 30,
          width: index == 5 ? 40 : 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                index == 5
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
            border:
                index == 5
                    ? null
                    : Border.all(color: Theme.of(context).colorScheme.primary),
          ),
          child: Center(
            child: Text(
              '5',
              style: TextStyle(
                color: index == 5
                    ? Colors.white : Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
