import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:design_common/selectable_chip.dart';

void main() {
  testWidgets('SelectableChip shows label & toggles selection', (tester) async {
    bool? lastSelected;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SelectableChip(
            label: 'Test Chip',
            initiallySelected: false,
            onSelected: (selected) {
              lastSelected = selected;
            },
          ),
        ),
      ),
    );

    expect(find.text('Test Chip'), findsOneWidget);


    Text textWidget =
    tester.widget<Text>(find.text('Test Chip'));
    expect(textWidget.style!.fontWeight, FontWeight.normal);

    await tester.tap(find.byType(SelectableChip));
    await tester.pump();

    expect(lastSelected, isTrue);

    textWidget = tester.widget<Text>(find.text('Test Chip'));
    expect(textWidget.style!.fontWeight, FontWeight.bold);

    await tester.tap(find.byType(SelectableChip));
    await tester.pump();

    expect(lastSelected, isFalse);

    textWidget = tester.widget<Text>(find.text('Test Chip'));
    expect(textWidget.style!.fontWeight, FontWeight.normal);
  });
}
