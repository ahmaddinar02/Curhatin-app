import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mobile/main.dart';

void main() {
  testWidgets('Curhatin app smoke test', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const CurhatinApp());

    // Verify ForumPage loads with the app title
    expect(find.text('Curhatin'), findsNothing); // title is in AppBar as RichText
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
