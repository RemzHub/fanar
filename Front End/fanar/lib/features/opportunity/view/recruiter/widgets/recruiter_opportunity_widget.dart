import 'package:fanar/core/common/widgets/custom_elevated_button.dart';
import 'package:fanar/core/utils/dialog_manager.dart';
import 'package:fanar/features/auth/controller/auth_controller.dart';
import 'package:fanar/features/auth/logic/model/profile.dart';
import 'package:fanar/features/opportunity/controller/opportunity_controller.dart';
import 'package:fanar/features/opportunity/view/recruiter/screens/add_opportunity_screen.dart';
import 'package:fanar/features/opportunity/view/widgets/opportunity_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecruiterOpportunityWidget extends StatelessWidget {
  const RecruiterOpportunityWidget({super.key});

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
          label: 'إضافة فرصة جديدة',
          borderRadiusCircular: 0.0,
          backgroundColor: Theme.of(context).colorScheme.primary,
          onPressed: () {
            final profile = AuthController.to.user.profile;
            if (profile is RecruiterProfile) {
              if (profile.organizationName.isEmpty) {
                DialogManager().showSnackBar(
                  'أكمل ملفك الشخصي',
                  'لابد أن تكمل ملفك الشخصي قبل أن تضيف فرصة جديدة',
                );
              } else {
                Get.toNamed(AddOpportunityScreen.routeName);
              }
            }
          },
        ),
      ],
    );
  }
}
