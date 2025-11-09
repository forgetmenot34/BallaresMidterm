import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ballaresmidterm/main.dart';

void main() {
  testWidgets('Student form validation and navigation', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: MidtermEnrollmentApp()));

    // Empty fields should show validation
    await tester.tap(find.text('Next → Select Course'));
    await tester.pump();
    expect(find.text('Required'), findsWidgets);

    // Fill fields properly
    await tester.enterText(find.byType(TextFormField).at(0), 'John');
    await tester.enterText(find.byType(TextFormField).at(1), 'Doe');
    await tester.enterText(find.byType(TextFormField).at(2), 'john@email.com');
    await tester.enterText(find.byType(TextFormField).at(3), '12345');

    await tester.tap(find.text('Next → Select Course'));
    await tester.pumpAndSettle();

    expect(find.text('Select Course'), findsOneWidget);
  });
}
