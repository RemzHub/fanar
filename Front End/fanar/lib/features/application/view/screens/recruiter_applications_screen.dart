import 'package:fanar/core/common/model/status.dart';
import 'package:fanar/core/common/widgets/custom_elevated_button.dart';
import 'package:fanar/core/network/api_constants.dart';
import 'package:fanar/core/theme/theme_controller.dart';
import 'package:fanar/features/application/data/recruiter_applications.dart';
import 'package:fanar/features/application/logic/application_controller.dart';
import 'package:fanar/features/opportunity/controller/opportunity_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecruiterApplicationsScreen extends StatefulWidget {
  final List<RecruiterApplications> applications;
  const RecruiterApplicationsScreen({
    super.key,
    required this.applications,
  });

  @override
  State<RecruiterApplicationsScreen> createState() =>
      _RecruiterApplicationsScreenState();
}

class _RecruiterApplicationsScreenState
    extends State<RecruiterApplicationsScreen> {
  @override
  Widget build(BuildContext context) {
    final double appBarHeight = kToolbarHeight;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
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
          padding: EdgeInsets.only(
            top: appBarHeight + statusBarHeight,
            left: 16.0,
            right: 16.0,
          ),
          child: GetBuilder<ApplicationController>(
            builder: (controller) => ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: widget.applications.length,
              itemBuilder: (context, index) {
                final application = widget.applications[index];
                return Card(
                  margin: EdgeInsets.only(
                    bottom: 16.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                  color: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                CircleAvatar(
                                  radius: 56.0,
                                  backgroundImage: CachedNetworkImageProvider(
                                    ApiConstants.mediaPreview(application
                                        .performerProfile.profileImage),
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  application.performerProfile.firstName,
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 200,
                              child: Wrap(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'الجنس: ',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                      ),
                                      const SizedBox(width: 4.0),
                                      Text(
                                        application
                                            .performerProfile.gender.name,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 8.0),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'الجنسية: ',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                      ),
                                      const SizedBox(width: 4.0),
                                      Text(
                                        application
                                            .performerProfile.nationality.name,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 8.0),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'الإقامة: ',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                      ),
                                      const SizedBox(width: 4.0),
                                      Text(
                                        '${application.performerProfile.residenceCountry.name} - ${application.performerProfile.residenceCity.name}',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 8.0),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'الدور العام: ',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                      ),
                                      const SizedBox(width: 4.0),
                                      Text(
                                        application
                                            .performerProfile.generalRole.name,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 8.0),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 223, 218, 218),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            application.coverLetter,
                          ),
                        ),
                        Divider(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        if (application.status.id == 3)
                          SizedBox(
                            height: 32.0,
                            child: CustomElevatedButton(
                              label: 'عرض الملف الشخصي',
                              borderRadiusCircular: 8.0,
                              backgroundColor:
                                  const Color.fromARGB(255, 12, 108, 187),
                              onPressed: () {
                                // Get.to(
                                //   () => ProfileScreen(
                                //     id: 1,
                                //   ),
                                // );
                              },
                            ),
                          ),
                        if (application.status.id == 3)
                          Divider(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        const SizedBox(height: 8.0),
                        if (application.status.id == 3)
                          SizedBox(
                            height: 32.0,
                            child: Row(
                              children: [
                                Expanded(
                                  child: CustomElevatedButton(
                                    label: 'قبول',
                                    onPressed: () async {
                                      final result = await controller
                                          .switchApplicationStatus(
                                        application.id,
                                        1,
                                      );
                                      if (result.$1) {
                                        setState(() {
                                          widget.applications[index] =
                                              application.copyWith(
                                                  status: Status.fromJson(result
                                                          .$3
                                                      as Map<String, dynamic>));
                                        });
                                        OpportunityController.to
                                            .fetchRecruiterOpportunities();
                                      }
                                    },
                                    borderRadiusCircular: 8.0,
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                Expanded(
                                  child: CustomElevatedButton(
                                    label: 'رفض',
                                    onPressed: () async {
                                      final result = await controller
                                          .switchApplicationStatus(
                                        application.id,
                                        2,
                                      );
                                      if (result.$1) {
                                        setState(() {
                                          widget.applications[index] =
                                              application.copyWith(
                                                  status: Status.fromJson(result
                                                          .$3
                                                      as Map<String, dynamic>));
                                        });
                                        OpportunityController.to
                                            .fetchRecruiterOpportunities();
                                      }
                                    },
                                    backgroundColor: Colors.red,
                                    borderRadiusCircular: 8.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (application.status.id != 3)
                          Text(
                            'حالة الطلب: ${application.status.name}',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 16.0,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
