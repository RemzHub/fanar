import 'package:fanar/core/common/model/status.dart';
import 'package:fanar/features/opportunity/logic/model/opportunity.dart';

class Application {
  final int id;
  final Opportunity opportunity;
  final int performerId;
  final String coverLetter;
  final Status status;
  final DateTime createdAt;

  Application({
    required this.id,
    required this.opportunity,
    required this.performerId,
    required this.coverLetter,
    required this.status,
    required this.createdAt,
  });
}
