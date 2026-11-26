import 'package:curhatin/features/chatbot/pages/chatbot_page.dart';
import 'package:curhatin/features/chatbot/widgets/chat_message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Bubble balasan tanpa profile dan maskot hanya muncul di balasan terakhir',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ChatbotPage(),
        ),
      );

      // Kirim pesan pertama
      await tester.enterText(find.byType(TextField), 'Halo');
      await tester.tap(find.byIcon(Icons.send_rounded));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pumpAndSettle();

      // Kirim pesan kedua
      await tester.enterText(find.byType(TextField), 'Aku merasa cemas');
      await tester.tap(find.byIcon(Icons.send_rounded));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pumpAndSettle();

      // Tidak ada avatar/profile ClipOval di dalam ChatMessageBubble
      expect(
        find.descendant(
          of: find.byType(ChatMessageBubble),
          matching: find.byType(ClipOval),
        ),
        findsNothing,
      );

      // Maskot aplikasi hanya muncul 1 kali (di balasan terakhir saja)
      final mascotFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Image &&
            widget.image is AssetImage &&
            (widget.image as AssetImage).assetName == 'assets/image/maskot.png',
      );
      expect(mascotFinder, findsOneWidget);

      // Pill top bar kanan atas (percakapan baru & delete) tampil
      expect(find.byIcon(Icons.edit_square), findsOneWidget);
      expect(find.byIcon(Icons.delete_outline_rounded), findsOneWidget);
    },
  );

  testWidgets(
    'Tombol percakapan baru & delete berfungsi dan pop-up riwayat tampilkan maks 10 chat',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ChatbotPage(),
        ),
      );

      // Kirim chat baru dengan judul unik
      await tester.enterText(find.byType(TextField), 'Curhat ujian besok');
      await tester.tap(find.byIcon(Icons.send_rounded));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pumpAndSettle();

      // Tekan tombol percakapan baru di pojok kanan atas
      await tester.tap(find.byIcon(Icons.edit_square));
      await tester.pumpAndSettle();
      expect(
        find.text('Halo, ada yang ingin kamu\ntanyakan...?'),
        findsOneWidget,
      );

      // Buka pop-up riwayat lewat tombol kiri bawah (=)
      await tester.tap(find.byIcon(Icons.drag_handle_rounded));
      await tester.pumpAndSettle();

      expect(find.text('Percakapan baru'), findsOneWidget);
      expect(find.text('Curhat ujian besok'), findsOneWidget);
      expect(find.text('Masalah pertemanan'), findsOneWidget);
      // Total ada 11 sesi (1 baru + 10 dummy), yang ditampilkan harus maks 10
      expect(find.text('Berbagi kabar baik'), findsNothing);

      // Pilih riwayat "Curhat ujian besok" dan cek apakah terbuka
      await tester.tap(find.text('Curhat ujian besok'));
      await tester.pumpAndSettle();
      expect(find.text('Curhat ujian besok'), findsOneWidget);

      // Hapus percakapan lewat tombol delete di pojok kanan atas
      await tester.tap(find.byIcon(Icons.delete_outline_rounded));
      await tester.pumpAndSettle();
      expect(
        find.text('Halo, ada yang ingin kamu\ntanyakan...?'),
        findsOneWidget,
      );
      expect(find.text('Percakapan dihapus'), findsOneWidget);

      // Cek di riwayat bahwa "Curhat ujian besok" sudah terhapus
      await tester.tap(find.byIcon(Icons.drag_handle_rounded));
      await tester.pumpAndSettle();
      expect(find.text('Curhat ujian besok'), findsNothing);
    },
  );
}
