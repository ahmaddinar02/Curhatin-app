import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/relaxation_theme.dart';
import '../models/relaxation_item_model.dart';
import '../data/dummy_relaxation_data.dart';
import '../widgets/relaxation_hero_section.dart';
import '../widgets/relaxation_menu_card.dart';
import 'sub_pages/meditation_page.dart';
import 'sub_pages/music_relaxation_page.dart';
import 'sub_pages/breathing_page.dart';
import 'sub_pages/story_reading_page.dart';

class RelaxationPage extends StatelessWidget {
  const RelaxationPage({super.key});

  void _navigate(BuildContext context, RelaxationItem item) {
    Widget page;
    switch (item.type) {
      case RelaxationType.meditation:
        page = const MeditationPage();
        break;
      case RelaxationType.music:
        page = const MusicRelaxationPage();
        break;
      case RelaxationType.breathing:
        page = const BreathingPage();
        break;
      case RelaxationType.story:
        page = const StoryReadingPage(isStory: true);
        break;
      case RelaxationType.reading:
        page = const StoryReadingPage(isStory: false);
        break;
    }
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RelaxationColors.background,
      appBar: _buildAppBar(context),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: [
          // Hero section — gradient biru + ilustrasi meditasi
          const RelaxationHeroSection(),

          const SizedBox(height: 16),

          // Label seksi
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Pilih Aktivitasmu',
              style: RelaxationTextStyles.sectionTitle,
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Temukan cara terbaik untuk merawat dirimu',
              style: RelaxationTextStyles.cardDescription,
            ),
          ),
          const SizedBox(height: 10),

          // Daftar menu
          ...DummyRelaxationData.menuItems.map(
            (item) => RelaxationMenuCard(
              item: item,
              onTap: () => _navigate(context, item),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: RelaxationColors.surfaceWhite,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      leading: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: GestureDetector(
          onTap: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          },
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
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: RelaxationColors.primary,
              size: 18,
            ),
          ),
        ),
      ),
      title: const Text('POJOK RELAKSASI', style: RelaxationTextStyles.appBarTitle),
      centerTitle: true,
      actions: const [SizedBox(width: 52)], // balancing spacer
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(height: 1, color: RelaxationColors.divider),
      ),
    );
  }
}
