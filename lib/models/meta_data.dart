class MetaData {
  final int id;
  final String title;

  MetaData({this.id, this.title});

  factory MetaData.fromJson(Map<String, dynamic> parsedJson) {

      return MetaData(
        id: parsedJson['id'],
        title: parsedJson['title'],
      );
  }
}
