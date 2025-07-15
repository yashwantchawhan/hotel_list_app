import 'package:flutter_test/flutter_test.dart';
import 'package:datasource_core/models/venue_item.dart';
import 'package:datasource_core/models/venue_data_display.dart';
import 'package:venue_list/domain/venue_data_model_mapper.dart';

void main() {
  late VenueDataModelMapperImpl mapper;

  setUp(() {
    mapper = VenueDataModelMapperImpl();
  });

  test('map() returns correct VenueDataDisplayModel with venues and filters', () {
    final venues = [
      VenueItem(
        id: 1,
        section: 'section',
        name: 'Venue 1',
        city: 'City 1',
        type: 'Type 1',
        location: 'Location 1',
        lat: 37.7749,
        lng: -122.4194,
        accessibleForGuestPass: true,
        imageUrls: ['image1.jpg'],
        categories: [],
        openingHours: {},
        overviewText: [],
        thingsToDo: [],
      ),
    ];

    final filters = [
      FilterItem(
        name: 'Filter 1',
        type: 'Type A',
        categories: [
          FilterCategory(id: '1', name: 'Category 1'),
          FilterCategory(id: '2', name: 'Category 2'),
        ],
      ),
      FilterItem(
        name: 'Filter 2',
        type: 'Type B',
        categories: [
          FilterCategory(id: '3', name: 'Category 3'),
        ],
      ),
    ];

    final result = mapper.map(venues, filters);

    expect(result, isA<VenueDataDisplayModel>());
    expect(result.venues, equals(venues));
    expect(result.filters, equals(filters));

    expect(result.filters.length, 2);
    expect(result.filters[0].categories.length, 2);
    expect(result.filters[1].categories.first.name, 'Category 3');
  });

  test('map() handles empty lists', () {
    final result = mapper.map([], []);

    expect(result.venues, isEmpty);
    expect(result.filters, isEmpty);
  });
}
