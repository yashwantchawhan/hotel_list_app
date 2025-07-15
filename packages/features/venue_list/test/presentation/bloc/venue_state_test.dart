import 'package:datasource_core/models/venue_data_display.dart';
import 'package:datasource_core/models/venue_item.dart';
import 'package:datasource_core/models/venue_item_display_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:venue_list/presentation/bloc/venue_state.dart';

void main() {
  group('VenueState', () {
    test('VenueLoadingState props should be empty', () {
      expect(VenueLoadingState().props, isEmpty);
    });

    test('VenueErrorState should store error message', () {
      const state = VenueErrorState(errorMessage: 'Something went wrong');
      expect(state.errorMessage, 'Something went wrong');
      expect(state.props, isEmpty); // props is empty in your code
    });

    test('VenueLoadedState should contain VenueDataDisplayModel', () {
      final venueDataDisplay = VenueDataDisplayModel(
        venues: [],
        filters: [],
      );

      final state = VenueLoadedState(venueDataDisplayModel: venueDataDisplay);

      expect(state.venueDataDisplayModel, venueDataDisplay);
      expect(state.props, [venueDataDisplay]);
    });

    test('VenueDetailState should contain VenueDetailsDisplayModel', () {
      final venueDetail = VenueDetailsDisplayModel(
        name: 'Venue',
        location: 'Location',
        openingHours: '09:00 - 20:00',
        overview: 'Nice place',
        imageUrls: [],
        amenities: [],
      );

      final state = VenueDetailState(venueItem: venueDetail);

      expect(state.venueItem, venueDetail);
      expect(state.props, [venueDetail]);
    });

    test('VenueMapViewState should contain venue item list', () {
      final venues = [
        VenueItem(
          id: 1,
          section: 'A',
          name: 'Venue 1',
          city: 'City',
          type: 'Type',
          location: 'Loc',
          lat: 0.0,
          lng: 0.0,
          accessibleForGuestPass: true,
          imageUrls: [],
          categories: [],
          openingHours: {},
          overviewText: [],
          thingsToDo: [],
        )
      ];

      final state = VenueMapViewState(venueItemList: venues);

      expect(state.venueItemList, venues);
      expect(state.props, [venues]);
    });

    test('FilterViewState props should be empty', () {
      expect(const FilterViewState().props, isEmpty);
    });
  });
}
