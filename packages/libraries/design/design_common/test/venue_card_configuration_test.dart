import 'package:design_common/venue_card_configuration.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('VenueCardConfiguration', () {
    test('should create an instance with correct values', () {
      const config = VenueCardConfiguration(
        imageUrls: ['url1', 'url2'],
        title: 'Venue Title',
        subtitle: 'Venue Subtitle',
      );

      expect(config.imageUrls, equals(['url1', 'url2']));
      expect(config.title, equals('Venue Title'));
      expect(config.subtitle, equals('Venue Subtitle'));
    });

    test('should allow empty imageUrls', () {
      const config = VenueCardConfiguration(
        imageUrls: [],
        title: 'Empty Images Venue',
        subtitle: 'No Images Here',
      );

      expect(config.imageUrls, isEmpty);
      expect(config.title, equals('Empty Images Venue'));
      expect(config.subtitle, equals('No Images Here'));
    });

    test('should compare instances by value when Equatable is used', () {
      const config1 = VenueCardConfiguration(
        imageUrls: ['url1'],
        title: 'Title',
        subtitle: 'Subtitle',
      );

      const config2 = VenueCardConfiguration(
        imageUrls: ['url1'],
        title: 'Title',
        subtitle: 'Subtitle',
      );

      expect(config1 == config2, isTrue);
    });
  });
}
