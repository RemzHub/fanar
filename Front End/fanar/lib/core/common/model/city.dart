class City {
  final int id;
  final String name;
  // final Country country;
  // final String state;

  City({
    required this.id,
    required this.name,
    // required this.country,
    // required this.state,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
      );
}
