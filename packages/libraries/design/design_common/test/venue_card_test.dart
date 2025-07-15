import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:design_common/venue_card.dart';
import 'package:design_common/venue_card_configuration.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  testWidgets('VenueCard displays title, subtitle and calls onTap', (tester) async {
    bool tapped = false;

    const config = VenueCardConfiguration(
      imageUrls: ['img1', 'img2'],
      title: 'Test Title',
      subtitle: 'Test Subtitle',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(builder: (context) {
            return VenueCard(
              configuration: config,
              onCardClick: () {
                tapped = true;
              },
            );
          }),
        ),
      ),
    );

    expect(find.text('Test Title'), findsOneWidget);
    expect(find.text('Test Subtitle'), findsOneWidget);

    await tester.tap(find.byType(VenueCard));
    await tester.pump();

    expect(tapped, isTrue);
  });
}
