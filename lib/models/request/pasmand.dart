class Pasmand {
  final int id;
  final String post_title;

  Pasmand({
    required this.id,
    required this.post_title,
  });

  factory Pasmand.fromJson(Map<String, dynamic> parsedJson) {
    return Pasmand(
      id: parsedJson['ID'],
      post_title: parsedJson['post_title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'post_title': post_title,
    };
  }
}
