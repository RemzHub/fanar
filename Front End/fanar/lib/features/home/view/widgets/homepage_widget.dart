import 'package:fanar/features/home/view/widgets/custom_carousel_widget.dart';
import 'package:fanar/features/home/view/widgets/homepage_current_rate_widget.dart';
import 'package:fanar/features/home/view/widgets/suggested_exercises_widget.dart';
import 'package:fanar/features/home/view/widgets/suggested_jobs_widget.dart';
import 'package:flutter/material.dart';

class HomepageWidget extends StatelessWidget {
  const HomepageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        CustomCarouselWidget(),
        SizedBox(height: 16.0),
        HomepageCurrentRateWidget(),
        SizedBox(height: 16.0),
        SuggestedExercisesWidget(),
        SizedBox(height: 16.0),
        SuggestedJobsWidget(),
      ],
    );
  }
}
