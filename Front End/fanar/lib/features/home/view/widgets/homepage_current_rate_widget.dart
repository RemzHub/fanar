import 'package:fanar/features/home/view/widgets/homepage_heading_title.dart';
import 'package:fanar/features/home/view/widgets/trait_widget.dart';
import 'package:flutter/material.dart';

class HomepageCurrentRateWidget extends StatelessWidget {
  const HomepageCurrentRateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomepageHeadingTitle(title: 'التقييم الحالي'),
        SizedBox(
          height: 130,
          width: double.infinity,
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              mainAxisExtent: 60,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            physics: NeverScrollableScrollPhysics(),
            children: [
              TraitWidget(
                name: 'سمة الفرح',
                emoji: '😀',
                rate: 50.0,
                color: Colors.green,
              ),
              TraitWidget(
                name: 'سمة الحزن',
                emoji: '🥲',
                rate: 20.0,
                color: Colors.amber,
              ),
              TraitWidget(
                name: 'سمة الغضب',
                emoji: '😠',
                rate: 70.0,
                color: Colors.red,
              ),
              TraitWidget(
                name: 'تعابير الوجه',
                emoji: '🎭',
                rate: 80.0,
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
