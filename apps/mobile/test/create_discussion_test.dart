import 'package:curhatin/features/forum/models/discussion_model.dart';
import 'package:curhatin/features/forum/pages/create_discussion_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'CreateDiscussionPage menampilkan judul Poppins bold tanpa kategori & media',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CreateDiscussionPage(),
        ),
      );

      final titleText = tester.widget<Text>(find.text('Diskusi Baru'));
      expect(titleText.style?.fontFamily, 'Poppins');
      expect(titleText.style?.fontWeight, FontWeight.bold);

      expect(find.text('Kategori'), findsNothing);
      expect(find.text('Tambahkan Media'), findsNothing);
      expect(find.text('Galeri'), findsNothing);
      expect(find.text('Kamera'), findsNothing);
    },
  );

  testWidgets(
    'CreateDiscussionPage mempublikasikan diskusi baru dengan teks valid',
    (WidgetTester tester) async {
      DiscussionModel? published;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () async {
                  published = await Navigator.of(context).push<DiscussionModel>(
                    MaterialPageRoute(
                      builder: (_) => const CreateDiscussionPage(),
                    ),
                  );
                },
                child: const Text('Buka'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Buka'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'Hari ini aku merasa lebih baik.');
      await tester.pump();

      await tester.tap(find.text('Publikasikan Diskusi'));
      await tester.pump(const Duration(milliseconds: 700));
      await tester.pumpAndSettle();

      expect(published, isNotNull);
      expect(published?.content, 'Hari ini aku merasa lebih baik.');
      expect(published?.category, 'Curhat');
    },
  );
}
