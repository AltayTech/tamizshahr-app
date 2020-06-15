class City {
  final int id;
  final String name;
  final String province_id;

  City({this.id, this.name,this.province_id});

  factory City.fromJson(Map<String, dynamic> parsedJson) {

      return City(
        id: parsedJson['id'],
        name: parsedJson['name'],
        province_id: parsedJson['province_id'],
      );
  }
  Map<String, dynamic> toJson() {


    return {
      'id' : id,
      'name' : name,
      'province_id' : province_id,
    };
  }
}
