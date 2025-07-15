import 'package:design_common/widgets/filter_chip_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('FilterChipWidget displays label and toggles selection',
          (WidgetTester tester) async {
        const label = 'Test Filter';

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: FilterChipWidget(label: label),
            ),
          ),
        );

        expect(find.text(label), findsOneWidget);

        final filterChipFinder = find.byType(FilterChip);

        FilterChip chip = tester.widget(filterChipFinder);
        expect(chip.selected, isFalse);

        await tester.tap(filterChipFinder);
        await tester.pump();

        chip = tester.widget(filterChipFinder);
        expect(chip.selected, isTrue);

        await tester.tap(filterChipFinder);
        await tester.pump();

        chip = tester.widget(filterChipFinder);
        expect(chip.selected, isFalse);
      });
}
