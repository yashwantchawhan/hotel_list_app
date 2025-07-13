import 'package:datasource_core/models/category.dart';
import 'package:datasource_core/models/things_to_do.dart';

class VenueItem {
  final int? id;
  final String section;
  final String name;
  final String city;
  final String type;
  final String location;
  final double lat;
  final double lng;
  final bool accessibleForGuestPass;
  final List<String> imageUrls;
  final List<Category> categories;
  final Map<String, dynamic> openingHours;
  final List<String> overviewText;
  final List<ThingToDo> thingsToDo;

  VenueItem({
    this.id,
    required this.section,
    required this.name,
    required this.city,
    required this.type,
    required this.location,
    required this.lat,
    required this.lng,
    required this.accessibleForGuestPass,
    required this.imageUrls,
    required this.categories,
    required this.openingHours,
    required this.overviewText,
    required this.thingsToDo,
  });

  factory VenueItem.fromJson(Map<String, dynamic> json) {
    return VenueItem(
      section: json['section'] ?? '',
      name: json['name'] ?? '',
      city: json['city'] ?? '',
      type: json['type'] ?? '',
      location: json['location'] ?? '',
      lat: json['coordinates']['lat'] ?? 0.0,
      lng: json['coordinates']['lng'] ?? 0.0,
      accessibleForGuestPass: json['accessibleForGuestPass'] ?? false,
      imageUrls: (json['images'] as List?)?.map((e) => e['url'] as String).toList() ?? [],
      categories: (json['categories'] as List?)?.map((e) => Category.fromJson(e)).toList() ?? [],
      openingHours: json['openingHours'] ?? {},
      overviewText: (json['overviewText'] as List?)?.map((e) => e['text'] as String).toList() ?? [],
      thingsToDo: (json['thingsToDo'] as List?)?.map((e) => ThingToDo.fromJson(e)).toList() ?? [],
    );
  }
}
