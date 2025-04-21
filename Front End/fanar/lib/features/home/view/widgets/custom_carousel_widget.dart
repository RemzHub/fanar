import 'package:fanar/core/constants/app_images.dart';
import 'package:fanar/features/home/view/widgets/carousel_card_widget.dart';
import 'package:fanar/features/home/view/widgets/homepage_heading_title.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CustomCarouselWidget extends StatelessWidget {
  const CustomCarouselWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomepageHeadingTitle(title: 'تمرن على المشاهد'),
        CarouselSlider(
          options: CarouselOptions(
            height: 220.0,
            autoPlay: true,
            enlargeCenterPage: true,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
          ),
          items: [
            CarouselCardWidget(
              title: 'الجوكر',
              description: '...',
              imageUrl: AppImages.joker,
            ),
            CarouselCardWidget(
              title: 'هانيبال',
              description: '...',
              imageUrl: AppImages.hannibal,
            ),
            CarouselCardWidget(
              title: 'بريان',
              description: '...',
              imageUrl: AppImages.bryan,
            ),
            CarouselCardWidget(
              title: 'مايكل',
              description: '...',
              imageUrl: AppImages.michael,
            ),
          ],
        ),
      ],
    );
  }
}
