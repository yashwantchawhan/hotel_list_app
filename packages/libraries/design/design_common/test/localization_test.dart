import 'package:design_common/localization.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Localization', () {
    test('should have correct static strings', () {
      expect(Localization.filterBy, 'Filter by');
      expect(Localization.city, 'City');
      expect(Localization.allUAE, 'All UAE');
      expect(Localization.availableForToday, 'Available for today');
      expect(Localization.venueType, 'Venue type');
      expect(Localization.hotelFacilities, 'Hotel facilities');
      expect(Localization.clearFilters, 'Clear filters');
      expect(Localization.showResults, 'Show results');
      expect(Localization.showMore, 'Show more');

      expect(Localization.poolAndBeach, 'Pool & Beach');
      expect(Localization.fitness, 'Fitness');
      expect(Localization.dining, 'Dining');
      expect(Localization.family, 'Family');

      expect(Localization.before2pm, 'Before 2pm');
      expect(Localization.after2pm, 'After 2pm');

      expect(Localization.hotel, 'Hotel');
      expect(Localization.beachClub, 'Beach club');
      expect(Localization.communityClub, 'Community club');

      expect(Localization.beach, 'Beach');
      expect(Localization.kidsPool, 'Kids pool');
      expect(Localization.adultsOnlyPool, 'Adults-only pool');
      expect(Localization.rooftopPool, 'Rooftop pool');

      expect(Localization.map, 'Map');
      expect(Localization.filters, 'Filters');
    });
  });
}
