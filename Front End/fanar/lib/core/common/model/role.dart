import 'package:fanar/features/auth/logic/model/user_type.dart';

class Role {
  final int id;
  final String name;
  final UserType userType;

  Role({
    required this.id,
    required this.name,
    required this.userType,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
        userType: UserType.fromJson(json['user_type']),
      );
}
