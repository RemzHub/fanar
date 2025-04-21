import 'package:fanar/core/common/model/city.dart';
import 'package:fanar/core/common/model/country.dart';
import 'package:fanar/core/common/model/role.dart';
import 'package:fanar/core/common/model/status.dart';
import 'package:fanar/features/auth/logic/model/profile.dart';
import 'package:fanar/features/auth/logic/model/user_type.dart';

class Opportunity {
  final int id;
  final RecruiterProfile recruiter;
  final String title;
  final String description;
  final Country country;
  final City city;
  final Status status;
  final Role role;
  final int numberCrew;
  final DateTime endDate;
  final DateTime createdAt;

  Opportunity({
    required this.id,
    required this.recruiter,
    required this.title,
    required this.description,
    required this.country,
    required this.city,
    required this.status,
    required this.role,
    required this.numberCrew,
    required this.endDate,
    required this.createdAt,
  });

  factory Opportunity.fromJson(Map<String, dynamic> json) => Opportunity(
        id: json['id'],
        recruiter: RecruiterProfile.fromJson(json['recruiter']),
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        country: Country.fromJson(json['country']),
        city: City.fromJson(json['city']),
        status: Status(
          id: json['status']['id'],
          name: json['status']['name'],
        ),
        role: Role(
          id: json['role']['id'],
          name: json['role']['name'],
          userType: UserType(
            id: 0,
            name: 'test',
          ),
        ),
        numberCrew: json['number_crew'],
        endDate: DateTime.parse(json['end_date']),
        createdAt: DateTime.parse(json['created_at']),
      );
}
