import 'package:fanar/core/common/widgets/custom_elevated_button.dart';
import 'package:fanar/core/common/widgets/custom_text_form_field.dart';
import 'package:fanar/core/theme/theme_controller.dart';
import 'package:fanar/core/utils/dialog_manager.dart';
import 'package:fanar/features/application/logic/application_controller.dart';
import 'package:fanar/features/auth/controller/auth_controller.dart';
import 'package:fanar/features/auth/logic/model/profile.dart';
import 'package:fanar/features/opportunity/logic/model/opportunity.dart';
import 'package:flutter/material.dart';

class OpportunityScreen extends StatelessWidget {
  static const String routeName = '/opportunity-screen';
  final Opportunity opportunity;
  const OpportunityScreen({
    required this.opportunity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: ThemeController().themeGradient,
        ),
        child: Padding(
          padding: EdgeInsets.only(),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ListView(
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    height: 250,
                    color: Colors.black38,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          opportunity.title,
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        Text(
                          '${opportunity.city.name} - ${opportunity.country.name}',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        Text(
                          'متبقي ${opportunity.endDate.difference(DateTime.now()).inDays} يوم',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Divider(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'الوصف',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          opportunity.description,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Divider(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'معلومات',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          'الحالة: ${opportunity.status.name}',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        Text(
                          'الدور المطلوب: ${opportunity.role.name}',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        Text(
                          'عدد الفرص: ${opportunity.numberCrew}',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Divider(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'عن المعلن',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          'اسم الجهة: ${opportunity.recruiter.organizationName}',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (AuthController.to.isPerformer.value)
                CustomElevatedButton(
                  label: 'تقديم',
                  borderRadiusCircular: 0.0,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  onPressed: () async {
                    final profile =
                        AuthController.to.user.profile as PerformerProfile;
                    if (profile.firstName.isEmpty) {
                      DialogManager()
                          .showSnackBar('خطأ', 'عليك إكمال الملف الشخصي أولاً');
                    } else {
                      var letter = '';
                      await showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            backgroundColor: Color(0xFF203A43),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: SizedBox(
                              height: 250,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16.0,
                                  horizontal: 8.0,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomTextFormField(
                                      title: 'رسالة التقديم',
                                      minLines: 3,
                                      maxLines: 4,
                                      onChanged: (value) {
                                        letter = value;
                                      },
                                    ),
                                    CustomElevatedButton(
                                      label: 'إرسال الطلب',
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );

                      final result =
                          await ApplicationController.to.sendApplication(
                        opportunity.id,
                        letter,
                        AuthController.to.user.token,
                      );

                      if (result.$1) {
                        DialogManager()
                            .showSnackBar('نجاح', 'تم تقديم طلبك بنجاح');
                      } else {
                        DialogManager()
                            .showSnackBar('خطأ', 'حصل خطأ اثناء تقديم طلبك');
                      }
                    }
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
