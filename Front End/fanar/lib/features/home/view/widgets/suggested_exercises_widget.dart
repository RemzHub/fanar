import 'package:fanar/core/constants/app_images.dart';
import 'package:fanar/features/home/view/widgets/course_widget.dart';
import 'package:fanar/features/home/view/widgets/homepage_heading_title.dart';
import 'package:flutter/material.dart';

class SuggestedExercisesWidget extends StatelessWidget {
  const SuggestedExercisesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomepageHeadingTitle(title: 'التدريبات المقترحة'),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CourseWidget(
                title: 'الضحك من المجاملة وحتى الهستيريا',
                description:
                    'تعلم في هذه الدورة كيف تضحك، من الضحك بشكل بسيط إلى الضحك الهستيري مثلما يضحك الجوكر',
                imageUrl: AppImages.loughTrait,
                ratings: 4.0,
                members: 10,
                price: 10.0,
              ),
              CourseWidget(
                title: 'تحكم بتفاصيل الوجه',
                description:
                    'تعلم في هذه الدورة التحكم بتفاصيل الوجه، وأهم النقاط الأساسية',
                imageUrl: AppImages.facialExpression,
                ratings: 4.8,
                members: 400,
                price: 50.0,
              ),
              CourseWidget(
                title: 'التعبير عن الغضب',
                description: 'تعلم في هذه الدورة إظهار مشاعر الغضب',
                imageUrl: AppImages.angerTrait,
                ratings: 4.3,
                members: 4157,
                price: 5.0,
              ),
              CourseWidget(
                title: 'كيف تعبر عن الحزن',
                description: 'تعلم في هذه الدورة إظهار مشاعر الحزن',
                imageUrl: AppImages.sadTrait,
                ratings: 2.57,
                members: 550,
                price: 20.0,
              ),
              CourseWidget(
                title: 'خفايا عن مشاعر الفرح',
                description: 'تعلم في هذه الدورة إظهار مشاعر الفرح',
                imageUrl: AppImages.happyTrait,
                ratings: 5,
                members: 20,
                price: 15.0,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
