import 'package:datasource_core/models/venue_item.dart';

class VenueDataDisplayModel {
  final List<VenueItem> venues;
  final List<FilterItem> filters;

  VenueDataDisplayModel({
    required this.venues,
    required this.filters,
  });
}

class FilterItem {
  final String name;
  final String type;
  final List<FilterCategory> categories;

  FilterItem({
    required this.name,
    required this.type,
    required this.categories,
  });

  factory FilterItem.fromJson(Map<String, dynamic> json) {
    return FilterItem(
      name: json['name'],
      type: json['type'],
      categories: (json['categories'] as List)
          .map((e) => FilterCategory.fromJson(e))
          .toList(),
    );
  }
}

class FilterCategory {
  final String id;
  final String name;

  FilterCategory({
    required this.id,
    required this.name,
  });

  factory FilterCategory.fromJson(Map<String, dynamic> json) {
    return FilterCategory(
      id: json['id'],
      name: json['name'],
    );
  }
}
