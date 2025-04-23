import 'package:fanar/core/common/widgets/custom_elevated_button.dart';
import 'package:fanar/features/test/autdio_widget.dart';
import 'package:fanar/features/test/widgets/record_widget.dart';
import 'package:fanar/features/test/widgets/test_stepper_indicator.dart';

import 'package:flutter/material.dart';

class HappinessTestWidget extends StatefulWidget {
  const HappinessTestWidget({super.key});

  @override
  State<HappinessTestWidget> createState() => _HappinessTestWidgetState();
}

class _HappinessTestWidgetState extends State<HappinessTestWidget> {
  String? audioPath;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TestStepperIndicator(index: 3),
        const SizedBox(height: 72.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'سمة الفرح',

                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text('كيف تُعبّر عن الفرح من خلال الصوت ؟'),
              const SizedBox(height: 32.0),
              Container(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                decoration: BoxDecoration(color: Color(0xFFFEF5ED)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'أقرأ النص وسجل صوتك',

                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(
                      color: Theme.of(context).colorScheme.primary,
                      thickness: 2.0,
                    ),
                    Text(
                      'مبروك يا غالي! الله يتمم لكم على خير ويجمع بينكم على حب وسعادة. بداية حياة جديدة مليانة أفراح وبركات. أسأل الله لكم دوام الحب والتوفيق في كل خطوة.',

                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 72.0),

              CustomElevatedButton(
                label: 'أضغط لبدأ التسجيل',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return RecordWidget(
                        onFinished: (path) {
                          if (path != null) {
                            setState(() {
                              audioPath = path;
                            });
                          }
                        },
                      );
                    },
                  );
                },
              ),
              if (audioPath != null) AudioWidget(audioPath: audioPath!),
            ],
          ),
        ),
      ],
    );
  }
}
