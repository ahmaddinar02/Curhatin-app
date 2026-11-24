import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/relaxation_theme.dart';

class MusicRelaxationPage extends StatefulWidget {
  const MusicRelaxationPage({super.key});

  @override
  State<MusicRelaxationPage> createState() => _MusicRelaxationPageState();
}

class _MusicRelaxationPageState extends State<MusicRelaxationPage> {
  int? _playingIndex;

  final List<Map<String, String>> _tracks = [
    {
      'title': 'Hujan Lembut',
      'desc': 'Suara hujan yang menenangkan',
      'duration': '30 menit',
      'emoji': '🌧️',
    },
    {
      'title': 'Alam Pegunungan',
      'desc': 'Suara burung dan angin sejuk',
      'duration': '45 menit',
      'emoji': '🏔️',
    },
    {
      'title': 'Ombak Pantai',
      'desc': 'Deburan ombak yang ritmis',
      'duration': '60 menit',
      'emoji': '🌊',
    },
    {
      'title': 'Hutan Bambu',
      'desc': 'Gemerisik bambu dan serangga',
      'duration': '30 menit',
      'emoji': '🎋',
    },
    {
      'title': 'Musik Piano Lembut',
      'desc': 'Melodi piano yang menenangkan jiwa',
      'duration': '40 menit',
      'emoji': '🎹',
    },
    {
      'title': 'White Noise',
      'desc': 'Suara putih untuk fokus & tidur',
      'duration': '60 menit',
      'emoji': '〰️',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RelaxationColors.background,
      appBar: _buildAppBar(context),
      body: ListView(
        padding: const EdgeInsets.only(top: 12, bottom: 32),
        children: [
          // Header info
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: RelaxationColors.music,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                const Text('🎵', style: TextStyle(fontSize: 36)),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Musik Relaksasi',
                          style: RelaxationTextStyles.cardTitle),
                      SizedBox(height: 4),
                      Text(
                        'Pilih suara favorit untuk menenangkan pikiran',
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
            child: Text('Pilih Musik', style: RelaxationTextStyles.sectionTitle),
          ),
          const SizedBox(height: 8),
          ..._tracks.asMap().entries.map((e) => _buildTrackCard(e.key, e.value)),
        ],
      ),
    );
  }

  Widget _buildTrackCard(int index, Map<String, String> track) {
    final isPlaying = _playingIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() => _playingIndex = isPlaying ? null : index);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isPlaying
                ? 'Musik dihentikan'
                : '${track['title']} sedang diputar 🎵'),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isPlaying
              ? RelaxationColors.primarySurface
              : RelaxationColors.surfaceWhite,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isPlaying
                ? RelaxationColors.primary
                : RelaxationColors.cardBorder,
            width: isPlaying ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Text(track['emoji']!, style: const TextStyle(fontSize: 32)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(track['title']!, style: RelaxationTextStyles.cardTitle),
                  const SizedBox(height: 2),
                  Text(track['desc']!, style: RelaxationTextStyles.cardDescription),
                ],
              ),
            ),
            Column(
              children: [
                Icon(
                  isPlaying
                      ? Icons.pause_circle_filled_rounded
                      : Icons.play_circle_filled_rounded,
                  color: RelaxationColors.primary,
                  size: 36,
                ),
                const SizedBox(height: 2),
                Text(track['duration']!, style: RelaxationTextStyles.caption),
              ],
            ),
          ],
        ),
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
      title: const Text('MUSIK RELAKSASI', style: RelaxationTextStyles.appBarTitle),
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
