import 'package:flutter/material.dart';

import '../features/assessment/assessment_intro_page.dart';
import '../features/forum/pages/create_discussion_page.dart';
import '../features/forum/pages/forum_page.dart';
import '../features/journal/journal_page_screens.dart';
import '../features/relaxation/pages/relaxation_page.dart';

/// Halaman Dashboard (Beranda) yang tampil setelah login.
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // Palet warna mengikuti halaman auth & jurnal.
  static const Color _blue = Color(0xFF2B6FDE);
  static const Color _navy = Color(0xFF061854);
  static const Color _grey = Color(0xFF808EAA);
  static const Color _bg = Color(0xFFD9EAFD);

  int? _selectedMood;

  static const List<_Mood> _moods = [
    _Mood('Sangat\nBuruk', Icons.sentiment_very_dissatisfied_rounded,
        Color(0xFFDCE6FB), Color(0xFF5C74C9)),
    _Mood('Buruk', Icons.sentiment_dissatisfied_rounded, Color(0xFFD3E4FB),
        Color(0xFF4A86D6)),
    _Mood('Biasa\nSaja', Icons.sentiment_neutral_rounded, Color(0xFFFFEBC2),
        Color(0xFFE9A21B)),
    _Mood('Baik', Icons.sentiment_satisfied_rounded, Color(0xFFD6F2D9),
        Color(0xFF3FA65A)),
    _Mood('Sangat\nBaik', Icons.sentiment_very_satisfied_rounded,
        Color(0xFFFFD9DF), Color(0xFFE5576F)),
  ];

  void _open(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  void _showSoon(String feature) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$feature segera hadir'),
          backgroundColor: _blue,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
        ),
      );
  }

  void _selectMood(int index) {
    setState(() => _selectedMood = index);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
              'Perasaanmu hari ini: ${_moods[index].label.replaceAll('\n', ' ')}'),
          backgroundColor: _blue,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/image/bg_bubble.jpg',
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFCFE3FD), Color(0xFFEAF3FF)],
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTopBar(),
                  const SizedBox(height: 10),
                  _buildGreeting(),
                  const SizedBox(height: 14),
                  _buildMoodCard(),
                  const SizedBox(height: 14),
                  _buildWideCard(
                    icon: Icons.assignment_outlined,
                    title: 'Asesmen Mandiri',
                    subtitle: 'Kenali kondisi mentalmu\nlebih dalam dengan DASS-21.',
                    actionLabel: 'Mulai',
                    onTap: () => _open(const AssessmentIntroPage()),
                  ),
                  const SizedBox(height: 12),
                  _buildWideCard(
                    icon: Icons.self_improvement_rounded,
                    title: 'Pojok Relaksasi',
                    subtitle: 'Luangkan waktu sejenak untuk\nmenenangkan diri',
                    actionLabel: 'Lihat Semua',
                    onTap: () => _open(const RelaxationPage()),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: _buildSmallCard(
                          icon: Icons.menu_book_rounded,
                          title: 'Jurnal Digital',
                          subtitle: 'Tulis apa yang kamu rasakan hari ini.',
                          actionLabel: 'Buka Jurnal',
                          onTap: () => _open(const JournalPage()),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildSmallCard(
                          imageAsset: 'assets/images/chatbot_logo.png',
                          icon: Icons.smart_toy_outlined,
                          title: 'Ngobrol dengan Athena...',
                          subtitle: 'Curhatin apa yang ada di pikiranmu.',
                          actionLabel: 'Mulai Chat',
                          onTap: () => _showSoon('Fitur chat Athena'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildDiscussionCard(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ── TOP BAR ────────────────────────────────────────────────────────
  Widget _buildTopBar() {
    return Row(
      children: [
        const Text(
          'Curhatin',
          style: TextStyle(
            color: Color(0xFF1B6FD8),
            fontSize: 28,
            fontWeight: FontWeight.w900,
            letterSpacing: -1.0,
          ),
        ),
        const SizedBox(width: 4),
        Container(
          width: 20,
          height: 20,
          decoration: const BoxDecoration(
              color: Color(0xFF1B6FD8), shape: BoxShape.circle),
          child: const Icon(Icons.favorite_rounded, color: Colors.white, size: 12),
        ),
        const Spacer(),
        _circleIconButton(
          Icons.notifications_none_rounded,
          () => _showSoon('Notifikasi'),
        ),
        const SizedBox(width: 8),
        _circleIconButton(
          Icons.settings_outlined,
          () => _showSoon('Pengaturan'),
        ),
      ],
    );
  }

  Widget _circleIconButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.85),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: _blue, size: 20),
      ),
    );
  }

  // ── GREETING ───────────────────────────────────────────────────────
  Widget _buildGreeting() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hai !!',
                style: TextStyle(
                  color: _navy,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Semoga hari ini\nlebih baik dari kemarin.',
                style: TextStyle(color: _grey, fontSize: 12, height: 1.4),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 110,
          height: 84,
          child: Image.asset(
            'assets/image/maskot.png',
            fit: BoxFit.contain,
            alignment: Alignment.bottomRight,
            errorBuilder: (_, _, _) => const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }

  // ── MOOD ───────────────────────────────────────────────────────────
  Widget _buildMoodCard() {
    return _card(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Bagaimana perasaan anda hari ini?',
            style: TextStyle(
                color: _navy, fontSize: 13, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          Row(
            children: List.generate(_moods.length, (i) {
              final mood = _moods[i];
              final selected = _selectedMood == i;
              return Expanded(
                child: GestureDetector(
                  onTap: () => _selectMood(i),
                  child: Padding(
                    padding: EdgeInsets.only(right: i == _moods.length - 1 ? 0 : 6),
                    child: Column(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          height: 46,
                          decoration: BoxDecoration(
                            color: mood.background,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: selected ? mood.foreground : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Icon(mood.icon,
                                color: mood.foreground, size: selected ? 30 : 26),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          mood.label,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: selected ? _navy : _grey,
                            fontSize: 9,
                            height: 1.2,
                            fontWeight:
                                selected ? FontWeight.w700 : FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  // ── KARTU MENU ─────────────────────────────────────────────────────
  Widget _buildWideCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String actionLabel,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: _card(
        child: Row(
          children: [
            _iconBadge(icon, 52),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          color: _navy,
                          fontSize: 14,
                          fontWeight: FontWeight.w800)),
                  const SizedBox(height: 2),
                  Text(subtitle,
                      style: const TextStyle(
                          color: _grey, fontSize: 11, height: 1.35)),
                ],
              ),
            ),
            const SizedBox(width: 6),
            _actionLink(actionLabel),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallCard({
    String? imageAsset,
    required IconData icon,
    required String title,
    required String subtitle,
    required String actionLabel,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: _card(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageAsset != null)
              SizedBox(
                width: 40,
                height: 40,
                child: Image.asset(
                  imageAsset,
                  fit: BoxFit.contain,
                  errorBuilder: (_, _, _) => _iconBadge(icon, 40),
                ),
              )
            else
              _iconBadge(icon, 40),
            const SizedBox(height: 8),
            Text(title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: _navy, fontSize: 12, fontWeight: FontWeight.w800)),
            const SizedBox(height: 2),
            Text(subtitle,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: _grey, fontSize: 10, height: 1.3)),
            const SizedBox(height: 8),
            _actionLink(actionLabel),
          ],
        ),
      ),
    );
  }

  // ── RUANG DISKUSI ──────────────────────────────────────────────────
  Widget _buildDiscussionCard() {
    return _card(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => _open(const ForumPage()),
            behavior: HitTestBehavior.opaque,
            child: Row(
              children: [
                _iconBadge(Icons.forum_outlined, 40),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ruang Diskusi',
                          style: TextStyle(
                              color: _navy,
                              fontSize: 14,
                              fontWeight: FontWeight.w800)),
                      SizedBox(height: 2),
                      Text('Berbagi cerita, pengalaman dan dukungan dengan sesama.',
                          style: TextStyle(
                              color: _grey, fontSize: 11, height: 1.35)),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right_rounded, color: _blue),
              ],
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => _open(const ForumPage()),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F7FF),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 14,
                        backgroundColor: Color(0xFFDCE8FB),
                        child: Text('A',
                            style: TextStyle(
                                color: _blue,
                                fontSize: 12,
                                fontWeight: FontWeight.w800)),
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ahmad dani',
                                style: TextStyle(
                                    color: _navy,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700)),
                            Text('7 jam lalu',
                                style: TextStyle(color: _grey, fontSize: 10)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Bagaimana cara kalian mengatasi rasa cemas saat banyak tugas menumpuk?',
                    style: TextStyle(color: _navy, fontSize: 12, height: 1.4),
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.favorite_border_rounded, size: 14, color: _grey),
                      SizedBox(width: 3),
                      Text('14', style: TextStyle(color: _grey, fontSize: 11)),
                      SizedBox(width: 12),
                      Icon(Icons.chat_bubble_outline_rounded,
                          size: 14, color: _grey),
                      SizedBox(width: 3),
                      Text('24', style: TextStyle(color: _grey, fontSize: 11)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _open(const CreateDiscussionPage()),
                  icon: const Icon(Icons.add_rounded, size: 16),
                  label: const Text('Buat Postingan'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _blue,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    textStyle: const TextStyle(
                        fontSize: 11, fontWeight: FontWeight.w700),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _showSoon('Post anonim'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: _blue,
                    side: const BorderSide(color: _blue),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    textStyle: const TextStyle(
                        fontSize: 11, fontWeight: FontWeight.w700),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text('Post Anonim'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── BOTTOM NAV ─────────────────────────────────────────────────────
  Widget _buildBottomNav() {
    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4A90D9).withValues(alpha: 0.18),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(Icons.home_rounded, 'Beranda', true, () {}),
            _navItem(Icons.history_rounded, 'Aktivitas', false,
                () => _open(const JournalPage())),
            _navItem(Icons.person_outline_rounded, 'Profil', false,
                () => _showSoon('Halaman profil')),
          ],
        ),
      ),
    );
  }

  Widget _navItem(
      IconData icon, String label, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(horizontal: active ? 18 : 12, vertical: 8),
        decoration: BoxDecoration(
          color: active ? const Color(0xFFE3EEFF) : Colors.transparent,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: active ? _blue : _grey, size: 22),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: active ? _blue : _grey,
                fontSize: 12,
                fontWeight: active ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── HELPERS ────────────────────────────────────────────────────────
  Widget _card({
    required Widget child,
    EdgeInsets padding = const EdgeInsets.all(14),
  }) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4A90D9).withValues(alpha: 0.10),
            blurRadius: 16,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _iconBadge(IconData icon, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFFE3EEFF),
        borderRadius: BorderRadius.circular(size * 0.32),
      ),
      child: Icon(icon, color: _blue, size: size * 0.52),
    );
  }

  Widget _actionLink(String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label,
            style: const TextStyle(
                color: _blue, fontSize: 11, fontWeight: FontWeight.w700)),
        const Icon(Icons.chevron_right_rounded, color: _blue, size: 16),
      ],
    );
  }
}

class _Mood {
  final String label;
  final IconData icon;
  final Color background;
  final Color foreground;

  const _Mood(this.label, this.icon, this.background, this.foreground);
}
