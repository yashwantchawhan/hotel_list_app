import 'dart:io';

import 'package:datasource_core/local_db/app_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  sqfliteFfiInit();
  setUp(() async {
    final file = File('/path/to/venues.db');
    if (await file.exists()) await file.delete();
  });
  setUpAll(() {
    // Replace the default factory with ffi factory for tests
    databaseFactory = databaseFactoryFfi;
  });

  test('AppDatabase creates and opens the database', () async {
    final db = await AppDatabase.database;

    // Check if db is open
    expect(db.isOpen, isTrue);

    // Check if venues table exists
    final tables = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name='venues';",
    );

    expect(tables.length, 1);
    expect(tables.first['name'], 'venues');

    // Insert a dummy venue
    final id = await db.insert('venues', {
      'section': 'Section A',
      'name': 'Test Venue',
      'city': 'Test City',
      'type': 'Hotel',
      'location': 'Somewhere',
      'lat': 25.0,
      'lng': 55.0,
      'accessibleForGuestPass': 1,
      'imageUrls': '[]',
      'categories_json': '[]',
      'openingHours_json': '{}',
      'overviewText_json': '[]',
      'thingsToDo_json': '[]',
    });

    expect(id, greaterThan(0));

    // Clean up
    await db.close();
  });
}
