import 'package:flutter/material.dart';

class CarouselCardWidget extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const CarouselCardWidget({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      padding: EdgeInsets.all(1),
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imageUrl,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 50.0,
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              color: Colors.black45,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () {},
                  child: Text(
                    'عرض المشهد',
                    style: TextStyle(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
