import 'package:fanar/core/common/model/status.dart';
import 'package:fanar/features/auth/logic/model/profile.dart';

class RecruiterApplications {
  final int id;
  final int opportunityId;
  final PerformerProfile performerProfile;
  final Status status;
  final String coverLetter;
  final DateTime createdAt;

  RecruiterApplications({
    required this.id,
    required this.opportunityId,
    required this.performerProfile,
    required this.status,
    required this.coverLetter,
    required this.createdAt,
  });

  factory RecruiterApplications.fromJson(Map<String, dynamic> json) =>
      RecruiterApplications(
        id: json['id'],
        opportunityId: json['opportunity_id'],
        performerProfile: PerformerProfile.fromJson(json['performer']),
        status: Status.fromJson(json['status']),
        coverLetter: json['cover_letter'],
        createdAt: DateTime.parse(json['created_at']),
      );

  RecruiterApplications copyWith({
    int? id,
    int? opportunityId,
    PerformerProfile? performerProfile,
    Status? status,
    String? coverLetter,
    DateTime? createdAt,
  }) {
    return RecruiterApplications(
      id: id ?? this.id,
      opportunityId: opportunityId ?? this.opportunityId,
      performerProfile: performerProfile ?? this.performerProfile,
      status: status ?? this.status,
      coverLetter: coverLetter ?? this.coverLetter,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
