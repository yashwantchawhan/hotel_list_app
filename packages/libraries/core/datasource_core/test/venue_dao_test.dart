import 'dart:io';
import 'package:datasource_core/local_db/app_database.dart';
import 'package:datasource_core/local_db/venue_dao.dart';
import 'package:datasource_core/models/category.dart';
import 'package:datasource_core/models/things_to_do.dart';
import 'package:datasource_core/models/venue_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


void main() {
  late VenueDao venueDao;

  setUpAll(() async {
    // Initialize sqflite_ffi for testing
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    // Force new db in tmp dir
    AppDatabase.reset();
    final dbPath = await databaseFactory.getDatabasesPath();
    final testDbFile = File('$dbPath/venues.db');
    if (await testDbFile.exists()) {
      await testDbFile.delete();
    }
  });

  setUp(() {
    venueDao = VenueDao();
  });

  test('insertVenues & getAllVenues & clearVenues & getVenueByName', () async {
    final venueItem = VenueItem(
      id: 1,
      section: 'A',
      name: 'Test Venue',
      city: 'Dubai',
      type: 'Hotel',
      location: 'Downtown',
      lat: 25.2048,
      lng: 55.2708,
      accessibleForGuestPass: true,
      imageUrls: ['img1.jpg', 'img2.jpg'],
      categories: [
        Category(
          id: "1",
          category: 'Category1',
          title: 'Title1',
          details: ['Detail1', 'Detail2'],
          showOnVenuePage: true,
        )
      ],
      openingHours: {'mon': '9-5'},
      overviewText: ['Overview line 1', 'Overview line 2'],
      thingsToDo: [
        ThingToDo(
          title: 'Swim',
          badge: 'Free',
          subtitle: 'Pool access',
        )
      ],
    );

    await venueDao.insertVenues([venueItem]);

    final venues = await venueDao.getAllVenues();
    expect(venues.length, 1);
    expect(venues.first.name, 'Test Venue');
    expect(venues.first.city, 'Dubai');

    final foundVenue = await venueDao.getVenueByName('Test Venue');
    expect(foundVenue, isNotNull);
    expect(foundVenue!.name, 'Test Venue');

    await venueDao.clearVenues();
    final emptyVenues = await venueDao.getAllVenues();
    expect(emptyVenues, isEmpty);
  });
}
