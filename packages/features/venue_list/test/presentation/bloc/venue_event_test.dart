import 'package:flutter_test/flutter_test.dart';
import 'package:venue_list/presentation/bloc/venue_event.dart';

void main() {
  group('VenueEvent', () {
    test('FetchVenue has empty props and equality', () {
      const event1 = FetchVenue();
      const event2 = FetchVenue();

      expect(event1.props, isEmpty);
      expect(event1, event2);
    });

    test('SearchVenueEvent has query prop and equality', () {
      const event1 = SearchVenueEvent(query: 'query');
      const event2 = SearchVenueEvent(query: 'query');
      const event3 = SearchVenueEvent(query: 'another');

      expect(event1.query, 'query');
      expect(event1.props, ['query']);
      expect(event1, event2);
      expect(event1 == event3, isFalse);
    });

    test('VenueDetailsEvent has name prop and equality', () {
      const event1 = VenueDetailsEvent(name: 'Venue1');
      const event2 = VenueDetailsEvent(name: 'Venue1');
      const event3 = VenueDetailsEvent(name: 'Venue2');

      expect(event1.name, 'Venue1');
      expect(event1.props, ['Venue1']);
      expect(event1, event2);
      expect(event1 == event3, isFalse);
    });

    test('MapViewEvent has empty props and equality', () {
      const event1 = MapViewEvent();
      const event2 = MapViewEvent();

      expect(event1.props, isEmpty);
      expect(event1, event2);
    });

    test('FilterViewEvent has empty props and equality', () {
      const event1 = FilterViewEvent();
      const event2 = FilterViewEvent();

      expect(event1.props, isEmpty);
      expect(event1, event2);
    });

    test('SearchVenue has query prop and equality', () {
      const event1 = SearchVenue('query');
      const event2 = SearchVenue('query');
      const event3 = SearchVenue('another');

      expect(event1.query, 'query');
      expect(event1.props, ['query']);
      expect(event1, event2);
      expect(event1 == event3, isFalse);
    });
  });
}
