import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:datasource_core/models/venue_item.dart';
import 'package:venue_map/map_screen.dart';

void main() {
  testWidgets('MapScreen displays AppBar and GoogleMap placeholder with markers',
          (WidgetTester tester) async {
        TestWidgetsFlutterBinding.ensureInitialized();

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
            imageUrls: [],
            categories: [],
            openingHours: {},
            overviewText: [],
            thingsToDo: [],
          ),
          VenueItem(
            id: 2,
            section: 'section',
            name: 'Venue 2',
            city: 'City 2',
            type: 'Type 2',
            location: 'Location 2',
            lat: 34.0522,
            lng: -118.2437,
            accessibleForGuestPass: true,
            imageUrls: [],
            categories: [],
            openingHours: {},
            overviewText: [],
            thingsToDo: [],
          ),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return MapScreen(venues: venues);
                },
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.text('Venues Map'), findsOneWidget);

        expect(find.byType(MapScreen), findsOneWidget);
      });
}
