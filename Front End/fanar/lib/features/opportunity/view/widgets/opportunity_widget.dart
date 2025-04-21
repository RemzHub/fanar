import 'package:fanar/core/common/widgets/custom_elevated_button.dart';
import 'package:fanar/features/application/view/screens/applications_screen.dart';
import 'package:fanar/features/opportunity/controller/opportunity_controller.dart';
import 'package:fanar/features/opportunity/view/widgets/opportunity_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OpportunityWidget extends StatelessWidget {
  const OpportunityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        GetBuilder<OpportunityController>(
          builder: (controller) {
            return RefreshIndicator(
              onRefresh: () => controller.fetchOpportunities(),
              child: ListView.builder(
                itemCount: controller.opportunity.length,
                itemBuilder: (context, index) {
                  return OpportunityCard(
                      opportunity: controller.opportunity[index]);
                },
                padding: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                ),
              ),
            );
          },
        ),
        CustomElevatedButton(
          label: 'متابعة الطلبات',
          borderRadiusCircular: 0.0,
          backgroundColor: Colors.blueGrey,
          onPressed: () {
            Get.toNamed(ApplicationsScreen.routeName);
          },
        ),
      ],
    );
  }
}
