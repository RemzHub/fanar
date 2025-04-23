import 'package:fanar/core/common/widgets/custom_elevated_button.dart';
import 'package:fanar/features/test/autdio_widget.dart';
import 'package:fanar/features/test/widgets/record_widget.dart';
import 'package:fanar/features/test/widgets/test_stepper_indicator.dart';

import 'package:flutter/material.dart';

class AngerTestWidget extends StatefulWidget {
  const AngerTestWidget({super.key});

  @override
  State<AngerTestWidget> createState() => _AngerTestWidgetState();
}

class _AngerTestWidgetState extends State<AngerTestWidget> {
  String? audioPath;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TestStepperIndicator(index: 1),
        const SizedBox(height: 72.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'سمة الغضب',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text('كيف تعبر عن الغضب من خلال الصوت؟'),
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
                      'لقد أخبرتك مرارا وتكرارا  أن هذا الأمر  يجب ينجز اليوم !كيف يمكنني العمل وسط هذه الفوضى ؟ أريد حلاً الأن',
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
