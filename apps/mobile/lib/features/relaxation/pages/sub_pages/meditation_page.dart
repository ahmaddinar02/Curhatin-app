import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/relaxation_theme.dart';
import '../../data/dummy_relaxation_data.dart';
import '../../models/relaxation_content_model.dart';

class MeditationPage extends StatefulWidget {
  const MeditationPage({super.key});

  @override
  State<MeditationPage> createState() => _MeditationPageState();
}

class _MeditationPageState extends State<MeditationPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final sessions = DummyRelaxationData.meditationSessions;
    final selected = sessions[_selectedIndex];

    return Scaffold(
      backgroundColor: RelaxationColors.background,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pilihan sesi
            SizedBox(
              height: 48,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                scrollDirection: Axis.horizontal,
                itemCount: sessions.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, i) {
                  final isSelected = i == _selectedIndex;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedIndex = i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? RelaxationColors.primary
                            : RelaxationColors.surfaceWhite,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? RelaxationColors.primary
                              : RelaxationColors.divider,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '${i + 1}. ${sessions[i].title.split('—')[0].trim()}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? Colors.white
                                : RelaxationColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Detail sesi
            _buildSessionCard(selected),

            // Langkah-langkah
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Text('Panduan Meditasi',
                  style: RelaxationTextStyles.sectionTitle),
            ),
            const SizedBox(height: 8),
            ...selected.steps.asMap().entries.map(
              (e) => _buildStepTile(e.key + 1, e.value),
            ),
            const SizedBox(height: 24),

            // Tombol mulai
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Sesi meditasi dimulai. Tutup mata dan rileks... 🧘'),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: RelaxationColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  icon: const Icon(Icons.play_arrow_rounded, size: 22),
                  label: Text(
                    'Mulai Meditasi (${selected.durationMinutes} menit)',
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionCard(MeditationSession session) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [RelaxationColors.heroGradientTop, RelaxationColors.heroGradientBottom],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Text('🧘‍♀️', style: TextStyle(fontSize: 48)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(session.title,
                    style: RelaxationTextStyles.cardTitle
                        .copyWith(color: RelaxationColors.primaryDark)),
                const SizedBox(height: 6),
                Text(session.description,
                    style: RelaxationTextStyles.cardDescription),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.timer_outlined,
                        size: 14, color: RelaxationColors.primary),
                    const SizedBox(width: 4),
                    Text('${session.durationMinutes} menit',
                        style: RelaxationTextStyles.cardAction
                            .copyWith(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepTile(int number, String step) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: RelaxationColors.surfaceWhite,
        borderRadius: BorderRadius.circular(12),
        border:
            Border.all(color: RelaxationColors.cardBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: RelaxationColors.primarySurface,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$number',
                style: const TextStyle(
                  color: RelaxationColors.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(step, style: RelaxationTextStyles.bodyText)),
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
      leading: _backButton(context),
      title: const Text('MEDITASI', style: RelaxationTextStyles.appBarTitle),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(height: 1, color: RelaxationColors.divider),
      ),
    );
  }

  Widget _backButton(BuildContext context) {
    return Padding(
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
    );
  }
}
