import 'package:fanar/features/opportunity/logic/model/opportunity.dart';
import 'package:fanar/features/opportunity/view/screens/opportunity_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OpportunityCard extends StatelessWidget {
  final Opportunity opportunity;
  const OpportunityCard({
    required this.opportunity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => OpportunityScreen(opportunity: opportunity));
      },
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        opportunity.title,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        opportunity.recruiter.organizationName,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 0.5,
                color: Theme.of(context).colorScheme.secondary,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        '${opportunity.country.name} - ',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      Text(
                        opportunity.city.name,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    opportunity.status.name,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
              Text(
                'الدور: ${opportunity.role.name}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Text(
                'الفرص: ${opportunity.numberCrew.toString()}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'منذ ${DateTime.now().difference(opportunity.createdAt).inDays} أيام',
                    style: TextStyle(
                      fontSize: 10,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
