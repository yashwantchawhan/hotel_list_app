import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:venue_details/presentation/widgets/venue_details_screen.dart';
import 'package:datasource_core/datasource_core.dart';


void main() {
  final testVenue = VenueDetailsDisplayModel(
    name: 'Test Venue',
    location: 'Test Location',
    openingHours: '09:00 - 20:00',
    overview: 'This is an overview of the test venue.',
    imageUrls: [
      'https://example.com/image1.jpg',
      'https://example.com/image2.jpg',
    ],
    amenities: [
      AmenityItem(
        title: 'Pool',
        subtitle: 'Outdoor, heated',
        note: 'Free access',
      ),
      AmenityItem(
        title: 'Gym',
        subtitle: '24/7 access',
        note: null,
      ),
    ],
  );

  Widget buildTestableWidget(Widget child) {
    return MaterialApp(home: child);
  }

  testWidgets('VenueDetailsScreen displays venue details', (tester) async {
    await tester.pumpWidget(buildTestableWidget(VenueDetailsScreen(venue: testVenue)));
    await tester.pump();

    expect(find.text('Test Venue'), findsOneWidget);
    expect(find.text('Test Location'), findsOneWidget);
    expect(find.text('09:00 - 20:00'), findsOneWidget);
    expect(find.text('This is an overview of the test venue.'), findsOneWidget);
    expect(find.text('Pool'), findsOneWidget);
    expect(find.text('Gym'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
  });

  testWidgets('Tapping back button pops navigation', (tester) async {
    final navKey = GlobalKey<NavigatorState>();

    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navKey,
        home: VenueDetailsScreen(venue: testVenue),
      ),
    );
    await tester.pump();

    expect(find.byIcon(Icons.arrow_back), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(navKey.currentState!.canPop(), isFalse);
  });
}

