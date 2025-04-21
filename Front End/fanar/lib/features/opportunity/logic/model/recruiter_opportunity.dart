import 'package:fanar/features/application/data/recruiter_applications.dart';

class RecruiterOpportunity {
  final int id;
  final int recruiterId;
  final String title;
  final String description;
  final int cityId;
  final int countryId;
  final int statusId;
  final String backgroundImage;
  final int numberCrew;
  final int roleId;
  final DateTime createdAt;
  final List<RecruiterApplications> applications;

  RecruiterOpportunity({
    required this.id,
    required this.recruiterId,
    required this.title,
    required this.description,
    required this.cityId,
    required this.countryId,
    required this.statusId,
    required this.backgroundImage,
    required this.numberCrew,
    required this.roleId,
    required this.createdAt,
    required this.applications,
  });

  factory RecruiterOpportunity.fromJson(Map<String, dynamic> json) =>
      RecruiterOpportunity(
        id: json['id'],
        recruiterId: json['recruiter_id'],
        title: json['title'],
        description: json['description'],
        cityId: json['city_id'],
        countryId: json['country_id'],
        statusId: json['opportunity_status_id'],
        backgroundImage: json['background_image'] ?? '',
        numberCrew: json['number_crew'],
        roleId: json['role_id'],
        createdAt: DateTime.parse(json['created_at']),
        applications: (json['applications'] as List).map(
          (e) {
            print(e);
            return RecruiterApplications.fromJson(e);
          },
        ).toList(),
      );
}
