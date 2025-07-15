import 'dart:async';

import 'package:datasource_core/local_db/venue_dao.dart';
import 'package:datasource_core/models/venue_data_display.dart';
import 'package:datasource_core/models/venue_item.dart';
import 'package:datasource_core/remote/api_service.dart';
import 'package:datasource_core/repositories/venue_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockVenueDao extends Mock implements VenueDao {}

class MockApiService extends Mock implements ApiService {}

void main() {
  late VenueRepositoryImpl repository;
  late MockVenueDao mockDao;
  late MockApiService mockApiService;

  final testVenue = VenueItem(
    id: 1,
    section: 'section',
    name: 'Venue 1',
    city: 'Dubai',
    type: 'Hotel',
    location: 'Location 1',
    lat: 25.276987,
    lng: 55.296249,
    accessibleForGuestPass: true,
    imageUrls: ['img1.jpg', 'img2.jpg'],
    categories: [],
    openingHours: {},
    overviewText: ['Overview'],
    thingsToDo: [],
  );

  final testFilter = FilterItem(
    name: 'Filter1',
    type: 'Type1',
    categories: [],
  );

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    registerFallbackValue(testVenue);
    registerFallbackValue(<VenueItem>[]);
  });

  setUp(() {
    mockDao = MockVenueDao();
    mockApiService = MockApiService();
    repository = VenueRepositoryImpl(venueDao: mockDao, apiService: mockApiService);
  });

  tearDown(() {
    repository.dispose();
  });

  test('getVenues returns cached venues if available', () async {
    when(() => mockDao.getAllVenues()).thenAnswer((_) async => [testVenue]);

    final result = await repository.getVenues();

    expect(result, isNotEmpty);
    expect(result.first.name, equals('Venue 1'));

    verify(() => mockDao.getAllVenues()).called(greaterThanOrEqualTo(1));
  });

  test('getVenues refreshes if no cached venues', () async {
    when(() => mockDao.getAllVenues()).thenAnswer((_) async => []);
    when(() => mockApiService.getAllVenues()).thenAnswer((_) async => [testVenue]);
    when(() => mockDao.clearVenues()).thenAnswer((_) async => {});
    when(() => mockDao.insertVenues(any())).thenAnswer((_) async => {});
    when(() => mockDao.getAllVenues()).thenAnswer((_) async => [testVenue]);

    final result = await repository.getVenues();

    expect(result, isNotEmpty);
    expect(result.first.name, equals('Venue 1'));

    verify(() => mockApiService.getAllVenues()).called(1);
  });

  test('getVenueByName returns venue if found', () async {
    when(() => mockDao.getVenueByName('Venue 1')).thenAnswer((_) async => testVenue);

    final result = await repository.getVenueByName('Venue 1');

    expect(result, isNotNull);
    expect(result?.name, equals('Venue 1'));
  });

  test('getVenueByName refreshes and tries again if not found', () async {
    when(() => mockDao.getVenueByName('Venue 1')).thenAnswer((_) async => null);
    when(() => mockApiService.getAllVenues()).thenAnswer((_) async => [testVenue]);
    when(() => mockDao.clearVenues()).thenAnswer((_) async => {});
    when(() => mockDao.insertVenues(any())).thenAnswer((_) async => {});
    when(() => mockDao.getAllVenues()).thenAnswer((_) async => [testVenue]);
    when(() => mockDao.getVenueByName('Venue 1')).thenAnswer((_) async => testVenue);

    final result = await repository.getVenueByName('Venue 1');

    expect(result, isNotNull);
    expect(result?.name, equals('Venue 1'));
  });

  test('getFiltersFromAssets calls apiService.getFilters', () async {
    when(() => mockApiService.getFilters()).thenAnswer((_) async => [testFilter]);

    final result = await repository.getFiltersFromAssets();

    expect(result, isNotNull);
    expect(result!.first.name, equals('Filter1'));

    verify(() => mockApiService.getFilters()).called(1);
  });

  test('searchVenues filters venues correctly', () async {
    when(() => mockDao.getAllVenues()).thenAnswer((_) async => [testVenue]);

    final result = await repository.searchVenues('Venue');

    expect(result, isNotEmpty);
    expect(result.first.name, equals('Venue 1'));

    verify(() => mockDao.getAllVenues()).called(1);
  });

  test('venueStream emits venues', () async {
    when(() => mockDao.getAllVenues()).thenAnswer((_) async => [testVenue]);

    unawaited(repository.getVenues());

    expectLater(
      repository.venueStream,
      emits(isA<List<VenueItem>>().having((list) => list.first.name, 'first.name', 'Venue 1')),
    );
  });
}
