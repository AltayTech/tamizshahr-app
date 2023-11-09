class Belongs {
  final int id;
  final String name;

  Belongs({
    required this.id,
    required this.name,
  });

  factory Belongs.fromJson(Map<String, dynamic> parsedJson) {
    return Belongs(
      id: parsedJson['id'] != null ? parsedJson['id'] : 0,
      name: parsedJson['name'] != null ? parsedJson['name'] : '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
