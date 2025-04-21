import 'package:fanar/features/application/view/screens/recruiter_applications_screen.dart';
import 'package:fanar/features/opportunity/controller/opportunity_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecruiterOpportunities extends StatelessWidget {
  static const String routeName = '/recruiter-opportunities-screen';
  const RecruiterOpportunities({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: GetBuilder<OpportunityController>(
        builder: (controller) => RefreshIndicator(
          onRefresh: () => controller.fetchRecruiterOpportunities(),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: controller.recruiterOpportunities.length,
            itemBuilder: (context, index) {
              final opportunity = controller.recruiterOpportunities[index];
              return GestureDetector(
                onTap: () => Get.to(
                 ()=>  RecruiterApplicationsScreen(
                      applications: opportunity.applications),
                ),
                child: Card(
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
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        opportunity.title,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 0.5,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              Text(
                                'عدد الطلبات: ${opportunity.applications.length}',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'منذ ${DateTime.now().difference(opportunity.createdAt).inDays} أيام',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 32.0,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
