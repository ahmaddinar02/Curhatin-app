import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/relaxation_theme.dart';
import '../../data/dummy_relaxation_data.dart';
import '../../models/relaxation_content_model.dart';

class StoryReadingPage extends StatelessWidget {
  final bool isStory; // true = Ruang Cerita, false = Ruang Baca

  const StoryReadingPage({super.key, required this.isStory});

  @override
  Widget build(BuildContext context) {
    final items =
        isStory ? DummyRelaxationData.stories : DummyRelaxationData.readings;
    final title = isStory ? 'RUANG CERITA' : 'RUANG BACA';
    final emoji = isStory ? '📖' : '📚';

    return Scaffold(
      backgroundColor: RelaxationColors.background,
      appBar: _buildAppBar(context, title),
      body: ListView(
        padding: const EdgeInsets.only(top: 12, bottom: 32),
        children: [
          // Header banner
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isStory
                  ? RelaxationColors.story
                  : RelaxationColors.reading,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Text(emoji, style: const TextStyle(fontSize: 36)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isStory ? 'Ruang Cerita' : 'Ruang Baca',
                        style: RelaxationTextStyles.cardTitle,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isStory
                            ? 'Temukan makna & ketenangan melalui cerita'
                            : 'Inspirasi & wawasan untuk jiwa yang sehat',
                        style: RelaxationTextStyles.cardDescription,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              isStory ? 'Pilih Cerita' : 'Pilih Artikel',
              style: RelaxationTextStyles.sectionTitle,
            ),
          ),
          const SizedBox(height: 8),
          ...items.map((item) => _buildStoryCard(context, item)),
        ],
      ),
    );
  }

  Widget _buildStoryCard(BuildContext context, RelaxationStory story) {
    return GestureDetector(
      onTap: () => _openReader(context, story),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: RelaxationColors.surfaceWhite,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: RelaxationColors.cardBorder),
          boxShadow: const [
            BoxShadow(
              color: RelaxationColors.cardShadow,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(story.title,
                      style: RelaxationTextStyles.cardTitle),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: RelaxationColors.primarySurface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.access_time_rounded,
                          size: 11, color: RelaxationColors.primary),
                      const SizedBox(width: 3),
                      Text(
                        '${story.readingMinutes} mnt',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: RelaxationColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              story.author,
              style: RelaxationTextStyles.caption
                  .copyWith(color: RelaxationColors.primary),
            ),
            const SizedBox(height: 8),
            Text(
              story.excerpt,
              style: RelaxationTextStyles.cardDescription,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Baca selengkapnya',
                      style: RelaxationTextStyles.cardAction),
                  const Icon(Icons.chevron_right_rounded,
                      size: 16, color: RelaxationColors.primary),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openReader(BuildContext context, RelaxationStory story) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => _StoryDetailPage(story: story),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, String title) {
    return AppBar(
      backgroundColor: RelaxationColors.surfaceWhite,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      leading: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                color: RelaxationColors.primary, size: 18),
          ),
        ),
      ),
      title: Text(title, style: RelaxationTextStyles.appBarTitle),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(height: 1, color: RelaxationColors.divider),
      ),
    );
  }
}

// ── Detail pembaca ────────────────────────────────────────────────────────────
class _StoryDetailPage extends StatelessWidget {
  final RelaxationStory story;

  const _StoryDetailPage({required this.story});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RelaxationColors.surfaceWhite,
      appBar: AppBar(
        backgroundColor: RelaxationColors.surfaceWhite,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: RelaxationColors.primary, size: 18),
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(height: 1, color: RelaxationColors.divider),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(story.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: RelaxationColors.textPrimary,
                  height: 1.3,
                )),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.person_outline,
                    size: 14, color: RelaxationColors.primary),
                const SizedBox(width: 4),
                Text(story.author,
                    style: RelaxationTextStyles.caption
                        .copyWith(color: RelaxationColors.primary)),
                const SizedBox(width: 12),
                const Icon(Icons.access_time_outlined,
                    size: 14, color: RelaxationColors.textTertiary),
                const SizedBox(width: 4),
                Text('${story.readingMinutes} menit membaca',
                    style: RelaxationTextStyles.caption),
              ],
            ),
            const SizedBox(height: 20),
            Divider(color: RelaxationColors.divider),
            const SizedBox(height: 16),
            Text(story.content, style: RelaxationTextStyles.bodyText),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
