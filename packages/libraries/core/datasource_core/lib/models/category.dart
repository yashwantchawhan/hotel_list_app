class Category {
  final String id;
  final String category;
  final String? title;
  final List<String> details;
  final bool showOnVenuePage;

  Category({
    required this.id,
    required this.category,
    this.title,
    required this.details,
    required this.showOnVenuePage,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? '',
      category: json['category'] ?? '',
      title: json['title'],
      details: (json['detail'] as List?)?.map((e) => e['text'] as String).toList() ?? [],
      showOnVenuePage: json['showOnVenuePage'] ?? false,
    );
  }
}
