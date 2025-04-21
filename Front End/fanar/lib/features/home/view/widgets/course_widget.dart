import 'package:flutter/material.dart';

class CourseWidget extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final double ratings;
  final int members;
  final double price;

  const CourseWidget({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.ratings,
    required this.members,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 260,
      margin: EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      padding: EdgeInsets.only(
        bottom: 8.0,
      ),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.asset(
              imageUrl,
              height: 140,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8.0),
                Text(
                  description,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      ratings.toStringAsFixed(1),
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4.0),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.grey,
                          size: 16,
                        ),
                      ],
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      '($members)',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      price.toStringAsFixed(1),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 2.0),
                    Text(
                      'ر.س',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
