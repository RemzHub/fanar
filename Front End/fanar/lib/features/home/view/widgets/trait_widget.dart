import 'package:flutter/material.dart';

class TraitWidget extends StatelessWidget {
  final String name;
  final String emoji;
  final double rate;
  final Color color;
  const TraitWidget({
    super.key,
    required this.name,
    required this.emoji,
    required this.rate,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 12.0,
      ),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white70,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Text(
                '${rate.toStringAsFixed(1)}% $emoji',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.centerRight,
            children: [
              Container(
                height: 4.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              FractionallySizedBox(
                widthFactor: rate / 100,
                child: Container(
                  height: 4.0,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
