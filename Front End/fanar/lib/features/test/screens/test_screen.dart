import 'package:fanar/core/common/widgets/custom_elevated_button.dart';
import 'package:fanar/core/common/widgets/custom_text_button.dart';
import 'package:fanar/features/test/controller/test_controller.dart';
import 'package:fanar/features/test/widgets/anger_test_widget.dart';
import 'package:fanar/features/test/widgets/expression_test_widget.dart';
import 'package:fanar/features/test/widgets/happiness_test_widget.dart';
import 'package:fanar/features/test/widgets/sadness_test_widget.dart';
import 'package:fanar/features/test/widgets/test_result_widget.dart';
import 'package:fanar/features/test/widgets/test_stepper_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final testController = TestController.to;

    final testWidgets = <Widget>[
      AngerTestWidget(),
      SadnessTestWidget(),
      HappinessTestWidget(),

      ExpressionTestWidget(),
      TestResultWidget(
        results: {'sad': 0.5, 'angry': 0.7, 'happy': 0.3, 'expression': 1},
        celebrities: [],
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('الإختبار'),
        centerTitle: true,
        foregroundColor: Theme.of(context).primaryColor,
      ),
      body: PageView(children: testWidgets),
    );
  }
}
