class Filter {
  final int? id;
  final String name;
  final String type;

  Filter({this.id, required this.name, required this.type});

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'type': type,
  };

  factory Filter.fromMap(Map<String, dynamic> map) => Filter(
    id: map['id'],
    name: map['name'],
    type: map['type'],
  );
}