import 'dart:convert';

import 'package:datasource_core/remote/api_service.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_helper.dart';



void main() {
  const localDataPath = 'assets/data/venues.json';

  late ApiServiceImpl apiService;
  late TestAssetBundle mockBundle;

  final mockJson = {
    'items': [
      {
        'id': 1,
        'section': 'A',
        'name': 'Venue 1',
        'city': 'Dubai',
        'type': 'Hotel',
        'location': 'Location 1',
        'coordinates': {
          'lat': 25.276987,
          'lng': 55.296249,
        },
        'accessibleForGuestPass': true,
        'images': [
          { 'url': 'img1.jpg' }
        ],
        'categories': [],
        'openingHours': {},
        'overviewText': [
          { 'text': 'Nice venue' }
        ],
        'thingsToDo': []
      }
    ],
    'filters': [
      {
        'name': 'Filter 1',
        'type': 'type1',
        'categories': []
      }
    ]
  };


  setUp(() {
    mockBundle = TestAssetBundle({
      localDataPath: jsonEncode(mockJson),
    });

    apiService = ApiServiceImpl(bundle: mockBundle);
  });

  test('getAllVenues returns parsed venues', () async {
    final venues = await apiService.getAllVenues();

    expect(venues, isNotEmpty);
    expect(venues.first.name, equals('Venue 1'));
    expect(venues.first.city, equals('Dubai'));
  });

  test('getFilters returns parsed filters', () async {
    final filters = await apiService.getFilters();

    expect(filters, isNotNull);
    expect(filters!.first.name, equals('Filter 1'));
    expect(filters.first.type, equals('type1'));
  });

  test('getFilters returns null if json is invalid', () async {
    mockBundle = TestAssetBundle({
      localDataPath: 'invalid json'
    });

    apiService = ApiServiceImpl(bundle: mockBundle);

    final filters = await apiService.getFilters();

    expect(filters, isNull);
  });
}
