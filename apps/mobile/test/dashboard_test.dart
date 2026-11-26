import 'package:curhatin/features/relaxation/pages/relaxation_page.dart';
import 'package:curhatin/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Klik Pojok Relaksasi menampilkan notifikasi saat fitur belum final',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: DashboardPage(),
        ),
      );

      await tester.tap(find.text('Pojok Relaksasi'));
      await tester.pump();

      expect(find.text('Fitur akan tersedia segera'), findsOneWidget);
      expect(find.byType(RelaxationPage), findsNothing);
    },
  );

  testWidgets(
    'Klik Pojok Relaksasi membuka RelaxationPage saat isRelaxationEnabled true',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: DashboardPage(isRelaxationEnabled: true),
        ),
      );

      await tester.tap(find.text('Pojok Relaksasi'));
      await tester.pumpAndSettle();

      expect(find.byType(RelaxationPage), findsOneWidget);
    },
  );

  testWidgets(
    'Semua emote mood sejajar lurus dan warnanya sesuai',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: DashboardPage(),
        ),
      );

      final moodIcons = <IconData>[
        Icons.sentiment_very_dissatisfied_rounded,
        Icons.sentiment_dissatisfied_rounded,
        Icons.sentiment_neutral_rounded,
        Icons.sentiment_satisfied_rounded,
        Icons.sentiment_very_satisfied_rounded,
      ];

      final firstDy = tester.getCenter(find.byIcon(moodIcons.first)).dy;
      for (final icon in moodIcons) {
        expect(tester.getCenter(find.byIcon(icon)).dy, equals(firstDy));
      }

      // Pastikan item yang dipilih tetap sejajar lurus
      await tester.tap(find.byIcon(Icons.sentiment_very_dissatisfied_rounded));
      await tester.pumpAndSettle();

      final selectedDy = tester.getCenter(find.byIcon(moodIcons.first)).dy;
      for (final icon in moodIcons) {
        expect(tester.getCenter(find.byIcon(icon)).dy, equals(selectedDy));
      }
    },
  );
}
