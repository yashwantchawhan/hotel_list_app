import 'package:datasource_core/models/category.dart';
import 'package:datasource_core/models/things_to_do.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:datasource_core/models/venue_item.dart';
import 'package:datasource_core/models/venue_item_display_model.dart';
import 'package:venue_list/domain/venue_details_model_mapper.dart';

void main() {
  late VenueDetailsModelMapperImpl mapper;

  setUp(() {
    mapper = VenueDetailsModelMapperImpl();
  });

  test('map() correctly maps VenueItem to VenueDetailsDisplayModel', () {
    final venueItem = VenueItem(
      id: 1,
      section: 'section',
      name: 'Venue 1',
      city: 'City 1',
      type: 'Type 1',
      location: 'Location 1',
      lat: 37.7749,
      lng: -122.4194,
      accessibleForGuestPass: true,
      imageUrls: ['image1.jpg', 'image2.jpg'],
      categories: [
        Category(
          id: '1',
          category: 'Cat1',
          title: 'Category Title',
          details: ['Detail 1', 'Detail 2'],
          showOnVenuePage: true,
        ),
      ],
      openingHours: {'monday': '9-20'},
      overviewText: ['Overview part 1', 'Overview part 2'],
      thingsToDo: [
        ThingToDo(
          title: 'Activity 1',
          subtitle: 'Subtitle 1',
          badge: 'Badge 1',
        ),
      ],
    );

    final result = mapper.map(venueItem);

    expect(result.name, equals('Venue 1'));
    expect(result.location, equals('Location 1, City 1'));
    expect(result.openingHours, equals('09:00 - 20:00'));
    expect(result.overview, contains('Overview part 1'));
    expect(result.overview, contains('Overview part 2'));
    expect(result.imageUrls, equals(['image1.jpg', 'image2.jpg']));
    expect(result.amenities.length, 2);

    final categoryAmenity = result.amenities.first;
    expect(categoryAmenity.title, equals('Category Title'));
    expect(categoryAmenity.subtitle, contains('Detail 1'));
    expect(categoryAmenity.note, equals('Free access'));

    final thingToDoAmenity = result.amenities.last;
    expect(thingToDoAmenity.title, equals('Activity 1'));
    expect(thingToDoAmenity.subtitle, equals('Subtitle 1'));
    expect(thingToDoAmenity.note, equals('Badge 1'));
  });
}
