import 'package:curhatin/features/forum/models/discussion_model.dart';
import 'package:curhatin/features/forum/widgets/discussion_card.dart';
import 'package:curhatin/features/forum/widgets/forum_common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'DiscussionCard tidak menampilkan kategori dan ikon bookmark',
    (WidgetTester tester) async {
      final discussion = DiscussionModel(
        id: 'd1',
        userId: 'u1',
        userName: 'Anya Putri',
        userAvatar: 'https://example.com/avatar.png',
        content: 'Isi diskusi contoh untuk pengujian.',
        category: 'Kecemasan',
        createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
        likeCount: 24,
        commentCount: 8,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DiscussionCard(
              discussion: discussion,
              onLike: () {},
              onComment: () {},
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.text('Anya Putri'), findsOneWidget);
      expect(find.text('24'), findsOneWidget);
      expect(find.text('8'), findsOneWidget);
      expect(find.byType(CategoryBadge), findsNothing);
      expect(find.text('Kecemasan'), findsNothing);
      expect(find.byIcon(Icons.bookmark_border_rounded), findsNothing);
    },
  );
}
