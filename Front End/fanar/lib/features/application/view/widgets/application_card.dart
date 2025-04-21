import 'package:fanar/features/application/data/application.dart';
import 'package:flutter/material.dart';

class ApplicationCard extends StatelessWidget {
  final Application application;
  const ApplicationCard({
    super.key,
    required this.application,
  });

  @override
  Widget build(BuildContext context) {
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
                      application.opportunity.title,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      application.opportunity.recruiter.organizationName,
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
            Text(
              'رسالتك: ${application.coverLetter}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            Text(
              'الدور: ${application.opportunity.role.name}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            Text(
              'حالة الطلب: ${application.status.name}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'منذ ${DateTime.now().difference(application.createdAt).inDays} أيام',
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
    );
  }
}
