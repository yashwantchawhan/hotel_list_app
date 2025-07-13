class ThingToDo {
  final String title;
  final String? badge;
  final String? subtitle;

  ThingToDo({
    required this.title,
    this.badge,
    this.subtitle,
  });

  factory ThingToDo.fromJson(Map<String, dynamic> json) {
    return ThingToDo(
      title: json['title'] ?? '',
      badge: json['badge'],
      subtitle: json['subtitle'],
    );
  }
}
