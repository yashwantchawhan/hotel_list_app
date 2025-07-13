class City {
  final int? id;
  final String name;

  City({this.id, required this.name});

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
  };

  factory City.fromMap(Map<String, dynamic> map) => City(
    id: map['id'],
    name: map['name'],
  );
}