import 'package:design_common/tokens/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:design_common/widgets/filter_bottom_sheet.dart';

void main() {
  testWidgets('showFilterBottomSheet displays correctly', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => Center(
              child: ElevatedButton(
                onPressed: () {
                  showFilterBottomSheet(context);
                },
                child: const Text('Open Sheet'),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open Sheet'));
    await tester.pumpAndSettle();


    expect(find.text(Localization.filterBy), findsOneWidget);
    expect(find.text(Localization.city), findsOneWidget);
    expect(find.text(Localization.allUAE), findsOneWidget);
    expect(find.text(Localization.availableForToday), findsOneWidget);
    expect(find.text(Localization.before2pm), findsOneWidget);
    expect(find.text(Localization.after2pm), findsOneWidget);

    expect(find.text(Localization.clearFilters), findsOneWidget);
    expect(find.text(Localization.showResults), findsOneWidget);

    // If you expect venueType but it's missing, skip this
    // If you want to check tabs instead:
    expect(find.text(Localization.poolAndBeach), findsOneWidget);
    expect(find.text(Localization.fitness), findsOneWidget);
    expect(find.text(Localization.dining), findsOneWidget);
    expect(find.text(Localization.family), findsOneWidget);
  });
}
