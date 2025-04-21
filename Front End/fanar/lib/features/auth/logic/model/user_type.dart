class UserType {
  final int id;
  final String name;

  UserType({
    required this.id,
    required this.name,
  });

  factory UserType.fromJson(Map<String, dynamic> json) => UserType(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
      );
}
