import 'package:design_common/filter_map_button.dart';
import 'package:design_common/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('FilterAndMapButton shows Map & Filters and triggers callbacks', (tester) async {
    bool mapTapped = false;
    bool filterTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FilterAndMapButton(
            onMapTap: () {
              mapTapped = true;
            },
            onFilterTap: () {
              filterTapped = true;
            },
          ),
        ),
      ),
    );

    expect(find.text(Localization.map), findsOneWidget);
    expect(find.text(Localization.filters), findsOneWidget);

    await tester.tap(find.text(Localization.map));
    await tester.pump();

    expect(mapTapped, isTrue);

    await tester.tap(find.text(Localization.filters));
    await tester.pump();

    expect(filterTapped, isTrue);
  });
}
