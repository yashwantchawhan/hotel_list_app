import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'app_database.dart';
import '../models/venue_item.dart';
import '../models/category.dart';
import '../models/things_to_do.dart';

class VenueDao {
  /// Save all venues to DB (overwrites existing).
  Future<void> insertVenues(List<VenueItem> venues) async {
    final db = await AppDatabase.database;

    await db.transaction((txn) async {
      await txn.delete('venues'); // clear old data

      for (final venue in venues) {
        await txn.insert(
          'venues',
          {
            'section': venue.section,
            'name': venue.name,
            'city': venue.city,
            'type': venue.type,
            'location': venue.location,
            'lat': venue.lat,
            'lng': venue.lng,
            'accessibleForGuestPass': venue.accessibleForGuestPass ? 1 : 0,
            'imageUrls': jsonEncode(venue.imageUrls),
            'categories_json': jsonEncode(
              venue.categories.map((c) => {
                'id': c.id,
                'category': c.category,
                'title': c.title,
                'details': c.details,
                'showOnVenuePage': c.showOnVenuePage,
              }).toList(),
            ),
            'openingHours_json': jsonEncode(venue.openingHours),
            'overviewText_json': jsonEncode(venue.overviewText),
            'thingsToDo_json': jsonEncode(
              venue.thingsToDo.map((t) => {
                'title': t.title,
                'badge': t.badge,
                'subtitle': t.subtitle,
              }).toList(),
            ),
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  /// Get all venues from DB.
  Future<List<VenueItem>> getAllVenues() async {
    final db = await AppDatabase.database;

    final maps = await db.query('venues');

    return maps.map((map) {
      final openingHoursJson = map['openingHours_json'] as String?;
      final overviewTextJson = map['overviewText_json'] as String?;
      final imageUrlsJson = map['imageUrls'] as String?;
      final categoriesJson = map['categories_json'] as String?;
      final thingsToDoJson = map['thingsToDo_json'] as String?;

      return VenueItem(
        id: map['id'] as int,
        section: map['section'] as String,
        name: map['name'] as String,
        city: map['city'] as String,
        type: map['type'] as String,
        location: map['location'] as String,
        lat: map['lat'] as double,
        lng: map['lng'] as double,
        accessibleForGuestPass: (map['accessibleForGuestPass'] as int) == 1,

        imageUrls: (imageUrlsJson != null && imageUrlsJson.isNotEmpty)
            ? List<String>.from(jsonDecode(imageUrlsJson))
            : [],

        categories: (categoriesJson != null && categoriesJson.isNotEmpty)
            ? (jsonDecode(categoriesJson) as List)
            .map((e) => Category(
          id: e['id'],
          category: e['category'],
          title: e['title'],
          details: List<String>.from(e['details']),
          showOnVenuePage: e['showOnVenuePage'],
        ))
            .toList()
            : [],

        openingHours: (openingHoursJson != null && openingHoursJson.isNotEmpty)
            ? Map<String, dynamic>.from(jsonDecode(openingHoursJson))
            : {},

        overviewText: (overviewTextJson != null && overviewTextJson.isNotEmpty)
            ? List<String>.from(jsonDecode(overviewTextJson))
            : [],

        thingsToDo: (thingsToDoJson != null && thingsToDoJson.isNotEmpty)
            ? (jsonDecode(thingsToDoJson) as List)
            .map((e) => ThingToDo(
          title: e['title'],
          badge: e['badge'],
          subtitle: e['subtitle'],
        ))
            .toList()
            : [],
      );
    }).toList();
  }

  /// Clear all venues
  Future<void> clearVenues() async {
    final db = await AppDatabase.database;
    await db.delete('venues');
  }

  Future<VenueItem?> getVenueByName(String name) async {
    final db = await AppDatabase.database;

    final maps = await db.query(
      'venues',
      where: 'name = ?',
      whereArgs: [name],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return mapToVenueItem(maps.first);
    } else {
      return null;
    }
  }

  VenueItem mapToVenueItem(Map<String, Object?> map) {
    final openingHoursJson = map['openingHours_json'] as String?;
    final overviewTextJson = map['overviewText_json'] as String?;
    final imageUrlsJson = map['imageUrls'] as String?;
    final categoriesJson = map['categories_json'] as String?;
    final thingsToDoJson = map['thingsToDo_json'] as String?;

    return VenueItem(
      id: map['id'] as int,
      section: map['section'] as String,
      name: map['name'] as String,
      city: map['city'] as String,
      type: map['type'] as String,
      location: map['location'] as String,
      lat: map['lat'] as double,
      lng: map['lng'] as double,
      accessibleForGuestPass: (map['accessibleForGuestPass'] as int) == 1,
      imageUrls: (imageUrlsJson != null && imageUrlsJson.isNotEmpty)
          ? List<String>.from(jsonDecode(imageUrlsJson))
          : [],
      categories: (categoriesJson != null && categoriesJson.isNotEmpty)
          ? (jsonDecode(categoriesJson) as List)
          .map((e) => Category(
        id: e['id'],
        category: e['category'],
        title: e['title'],
        details: List<String>.from(e['details']),
        showOnVenuePage: e['showOnVenuePage'],
      ))
          .toList()
          : [],
      openingHours: (openingHoursJson != null && openingHoursJson.isNotEmpty)
          ? Map<String, dynamic>.from(jsonDecode(openingHoursJson))
          : {},
      overviewText: (overviewTextJson != null && overviewTextJson.isNotEmpty)
          ? List<String>.from(jsonDecode(overviewTextJson))
          : [],
      thingsToDo: (thingsToDoJson != null && thingsToDoJson.isNotEmpty)
          ? (jsonDecode(thingsToDoJson) as List)
          .map((e) => ThingToDo(
        title: e['title'],
        badge: e['badge'],
        subtitle: e['subtitle'],
      ))
          .toList()
          : [],
    );
  }

}
