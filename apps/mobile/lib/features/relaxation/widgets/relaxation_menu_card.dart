import 'package:flutter/material.dart';
import '../models/relaxation_item_model.dart';
import '../theme/relaxation_theme.dart';

/// Card item menu utama Pojok Relaksasi.
/// Sesuai referensi: ilustrasi kiri, judul + deskripsi tengah, "Mulai >" kanan.
class RelaxationMenuCard extends StatelessWidget {
  final RelaxationItem item;
  final VoidCallback onTap;

  const RelaxationMenuCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  Color get _illustrationBg {
    switch (item.type) {
      case RelaxationType.meditation:
        return RelaxationColors.meditation;
      case RelaxationType.music:
        return RelaxationColors.music;
      case RelaxationType.breathing:
        return RelaxationColors.breathing;
      case RelaxationType.story:
        return RelaxationColors.story;
      case RelaxationType.reading:
        return RelaxationColors.reading;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: RelaxationColors.surfaceWhite,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: RelaxationColors.cardBorder, width: 1),
          boxShadow: const [
            BoxShadow(
              color: RelaxationColors.cardShadow,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Ilustrasi (emoji dalam lingkaran berwarna)
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: _illustrationBg,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(
                  item.illustrationEmoji,
                  style: const TextStyle(fontSize: 28),
                ),
              ),
            ),

            const SizedBox(width: 14),

            // Judul + Deskripsi
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title, style: RelaxationTextStyles.cardTitle),
                  const SizedBox(height: 4),
                  Text(
                    item.description,
                    style: RelaxationTextStyles.cardDescription,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            // Tombol "Mulai >"
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Mulai', style: RelaxationTextStyles.cardAction),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: RelaxationColors.primary,
                  size: 18,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
