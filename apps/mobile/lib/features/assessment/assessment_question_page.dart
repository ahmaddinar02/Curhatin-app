import 'package:flutter/material.dart';
import '../../screens/dashboard.dart';
import '../journal/journal_page_screens.dart';
import '../relaxation/pages/relaxation_page.dart';

enum DassCategory { depression, anxiety, stress }

class DassQuestion {
  final int id;
  final String text;
  final DassCategory category;

  const DassQuestion({
    required this.id,
    required this.text,
    required this.category,
  });
}

class DassOption {
  final int score;
  final String title;
  final String subtitle;

  const DassOption({
    required this.score,
    required this.title,
    required this.subtitle,
  });
}

/// 21 Pertanyaan Baku Skala DASS-21 dalam Bahasa Indonesia (Adaptasi Mahasiswa)
const List<DassQuestion> kDass21Questions = [
  DassQuestion(
    id: 1,
    text: 'Saya merasa kehilangan semangat untuk mengerjakan tugas / skripsi / tugas akhir.',
    category: DassCategory.stress,
  ),
  DassQuestion(
    id: 2,
    text: 'Saya menyadari mulut saya terasa kering saat merasa cemas atau gugup.',
    category: DassCategory.anxiety,
  ),
  DassQuestion(
    id: 3,
    text: 'Saya sama sekali tidak dapat merasakan perasaan positif atau kegembiraan.',
    category: DassCategory.depression,
  ),
  DassQuestion(
    id: 4,
    text: 'Saya mengalami kesulitan bernapas (misalnya bernapas cepat, sesak napas tanpa aktivitas fisik).',
    category: DassCategory.anxiety,
  ),
  DassQuestion(
    id: 5,
    text: 'Saya merasa sulit untuk memulai inisiatif atau bersemangat dalam melakukan sesuatu.',
    category: DassCategory.depression,
  ),
  DassQuestion(
    id: 6,
    text: 'Saya cenderung bereaksi berlebihan terhadap situasi atau masalah tertentu.',
    category: DassCategory.stress,
  ),
  DassQuestion(
    id: 7,
    text: 'Saya merasakan getaran atau gemetar pada tangan atau bagian tubuh lainnya.',
    category: DassCategory.anxiety,
  ),
  DassQuestion(
    id: 8,
    text: 'Saya merasa menggunakan banyak energi saraf atau merasa sangat gelisah.',
    category: DassCategory.stress,
  ),
  DassQuestion(
    id: 9,
    text: 'Saya khawatir tentang situasi di mana saya mungkin panik atau tampak konyol.',
    category: DassCategory.anxiety,
  ),
  DassQuestion(
    id: 10,
    text: 'Saya merasa tidak ada hal baik yang dapat saya harapkan di masa depan.',
    category: DassCategory.depression,
  ),
  DassQuestion(
    id: 11,
    text: 'Saya mendapati diri saya mudah gelisah, resah, dan tidak sabar.',
    category: DassCategory.stress,
  ),
  DassQuestion(
    id: 12,
    text: 'Saya merasa sulit untuk rileks, tenang, atau bersantai.',
    category: DassCategory.stress,
  ),
  DassQuestion(
    id: 13,
    text: 'Saya merasa sedih, murung, dan putus asa.',
    category: DassCategory.depression,
  ),
  DassQuestion(
    id: 14,
    text: 'Saya tidak toleran terhadap apa pun yang menghalangi hal yang sedang saya kerjakan.',
    category: DassCategory.stress,
  ),
  DassQuestion(
    id: 15,
    text: 'Saya merasa hampir panik dalam situasi tertentu.',
    category: DassCategory.anxiety,
  ),
  DassQuestion(
    id: 16,
    text: 'Saya tidak dapat merasa antusias terhadap hal apa pun dalam keseharian saya.',
    category: DassCategory.depression,
  ),
  DassQuestion(
    id: 17,
    text: 'Saya merasa bahwa saya tidak berharga atau tidak berarti sebagai seseorang.',
    category: DassCategory.depression,
  ),
  DassQuestion(
    id: 18,
    text: 'Saya merasa diri saya cukup mudah tersinggung atau sensitif.',
    category: DassCategory.stress,
  ),
  DassQuestion(
    id: 19,
    text: 'Saya menyadari detak jantung saya tanpa melakukan latihan fisik (misalnya detak jantung berdebar kencang).',
    category: DassCategory.anxiety,
  ),
  DassQuestion(
    id: 20,
    text: 'Saya merasa takut tanpa alasan yang jelas atau masuk akal.',
    category: DassCategory.anxiety,
  ),
  DassQuestion(
    id: 21,
    text: 'Saya merasa bahwa hidup ini tidak berarti dan sia-sia.',
    category: DassCategory.depression,
  ),
];

const List<DassOption> kDassOptions = [
  DassOption(
    score: 0,
    title: 'Tidak pernah',
    subtitle: 'Tidak sesuai dengan saya sama sekali',
  ),
  DassOption(
    score: 1,
    title: 'Kadang-kadang',
    subtitle: 'Sesuai sampai tingkat tertentu',
  ),
  DassOption(
    score: 2,
    title: 'Sering',
    subtitle: 'Sesuai sampai batas yang cukup nyata',
  ),
  DassOption(
    score: 3,
    title: 'Hampir selalu',
    subtitle: 'Sangat sesuai dengan yang saya alami',
  ),
];

class AssessmentQuestionPage extends StatefulWidget {
  const AssessmentQuestionPage({super.key});

  @override
  State<AssessmentQuestionPage> createState() => _AssessmentQuestionPageState();
}

class _AssessmentQuestionPageState extends State<AssessmentQuestionPage> {
  int _currentIndex = 0;
  final Map<int, int> _answers = {}; // index (0..20) -> score (0..3)

  // Warna palet Curhatin
  static const Color _navy = Color(0xFF061854);
  static const Color _bluePrimary = Color(0xFF2B6FDE);
  static const Color _greyText = Color(0xFF64748B);
  static const Color _borderColor = Color(0xFFE2E8F0);

  void _onOptionSelected(int score) {
    setState(() {
      _answers[_currentIndex] = score;
    });
  }

  void _onNext() {
    if (!_answers.containsKey(_currentIndex)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Silakan pilih salah satu jawaban terlebih dahulu.',
            style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500),
          ),
          backgroundColor: const Color(0xFFE53935),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
        ),
      );
      return;
    }

    if (_currentIndex < kDass21Questions.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      // Selesai -> Buka Halaman Hasil Asesmen DASS-21
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => AssessmentResultPage(answers: _answers),
        ),
      );
    }
  }

  void _onPrevious() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = kDass21Questions[_currentIndex];
    final selectedScore = _answers[_currentIndex];
    final progress = (_currentIndex + 1) / kDass21Questions.length;
    final percent = (progress * 100).round();

    return Scaffold(
      backgroundColor: const Color(0xFFD9EAFD),
      body: Stack(
        children: [
          // ── BACKGROUND DEKORASI ASESMEN SENADA DENGAN DASHBOARD ─────
          const Positioned.fill(
            child: _AssessmentBackground(),
          ),

          // ── KONTEN UTAMA DENGAN POSISI LEBIH KETENGAH ──────────────
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 10),

                // ── TOP HEADER ───────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.maybePop(context),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF4A90D9).withValues(alpha: 0.16),
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.arrow_back_rounded,
                              color: Color(0xFF2B6FDE),
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      const Text(
                        'Asessment Mandiri',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: _navy,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 6),

                // ── AREA KARTU TERTENGAH SECARA VERTIKAL & HORIZONTAL ──
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: constraints.maxHeight - 16,
                              maxWidth: 480,
                            ),
                            child: IntrinsicHeight(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 8),

                                  // ── KARTU 1: PROGRESS ──────────────────────────
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(22),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(alpha: 0.12),
                                          blurRadius: 20,
                                          offset: const Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Baris "1/ 21"
                                        RichText(
                                          text: TextSpan(
                                            style: const TextStyle(fontFamily: 'Poppins'),
                                            children: [
                                              TextSpan(
                                                text: '${_currentIndex + 1}',
                                                style: const TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w800,
                                                  color: _navy,
                                                ),
                                              ),
                                              TextSpan(
                                                text: ' / ${kDass21Questions.length}',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: _greyText,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 8),

                                        // Progress Bar
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: LinearProgressIndicator(
                                            value: progress,
                                            minHeight: 7,
                                            backgroundColor: const Color(0xFFE8EEF8),
                                            valueColor: const AlwaysStoppedAnimation<Color>(_bluePrimary),
                                          ),
                                        ),
                                        const SizedBox(height: 8),

                                        // Baris label & persentase
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Skrining DASS-21 Mahasiswa',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: _greyText,
                                              ),
                                            ),
                                            Text(
                                              '$percent% Selesai',
                                              style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                color: _bluePrimary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 14),

                                  // ── KARTU 2: PERTANYAAN & OPSI ─────────────────
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(26),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(alpha: 0.12),
                                          blurRadius: 20,
                                          offset: const Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Label PERTANYAAN N
                                        Text(
                                          'PERTANYAAN ${_currentIndex + 1}',
                                          style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w800,
                                            color: _bluePrimary,
                                            letterSpacing: 0.8,
                                          ),
                                        ),
                                        const SizedBox(height: 8),

                                        // Teks Pertanyaan
                                        Text(
                                          '${_currentIndex + 1}. ${question.text}',
                                          style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 15.5,
                                            fontWeight: FontWeight.w800,
                                            color: _navy,
                                            height: 1.45,
                                          ),
                                        ),
                                        const SizedBox(height: 18),

                                        // Daftar 4 Pilihan Jawaban
                                        ...kDassOptions.map((opt) {
                                          final isSelected = selectedScore == opt.score;
                                          return _buildOptionItem(opt, isSelected);
                                        }),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 18),

                                  // ── TOMBOL NAVIGASI BAWAH ──────────────────────
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (_currentIndex > 0)
                                        GestureDetector(
                                          onTap: _onPrevious,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(28),
                                              border: Border.all(color: const Color(0xFFCBD5E1), width: 1.2),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black.withValues(alpha: 0.04),
                                                  blurRadius: 8,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: const Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(Icons.arrow_back_rounded, size: 18, color: Color(0xFF505F79)),
                                                SizedBox(width: 6),
                                                Text(
                                                  'Sebelumnya',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFF505F79),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      else
                                        const SizedBox.shrink(),

                                      // Tombol Selanjutnya / Selesai (Biru Senada Dashboard)
                                      GestureDetector(
                                        onTap: _onNext,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 13),
                                          decoration: BoxDecoration(
                                            color: _bluePrimary,
                                            borderRadius: BorderRadius.circular(28),
                                            boxShadow: [
                                              BoxShadow(
                                                color: _bluePrimary.withValues(alpha: 0.32),
                                                blurRadius: 12,
                                                offset: const Offset(0, 4),
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                _currentIndex == kDass21Questions.length - 1
                                                    ? 'Selesai'
                                                    : 'Selanjutnya',
                                                style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              const Icon(
                                                Icons.arrow_forward_rounded,
                                                size: 18,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 16),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionItem(DassOption opt, bool isSelected) {
    return GestureDetector(
      onTap: () => _onOptionSelected(opt.score),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF1F6FE) : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? _bluePrimary : _borderColor,
            width: isSelected ? 1.8 : 1.2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: _bluePrimary.withValues(alpha: 0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            // Lingkaran angka 0, 1, 2, 3
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? _bluePrimary : Colors.transparent,
                border: Border.all(
                  color: isSelected ? _bluePrimary : const Color(0xFF94A3B8),
                  width: 1.4,
                ),
              ),
              child: Center(
                child: Text(
                  '${opt.score}',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: isSelected ? Colors.white : const Color(0xFF64748B),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),

            // Teks Pilihan
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    opt.title,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: isSelected ? _bluePrimary : _navy,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    opt.subtitle,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11.5,
                      fontWeight: FontWeight.w400,
                      color: _greyText,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// HALAMAN HASIL ASESMEN DASS-21
// ─────────────────────────────────────────────────────────────────────────────
class AssessmentResultPage extends StatelessWidget {
  final Map<int, int> answers;

  const AssessmentResultPage({super.key, required this.answers});

  int get depressionScore {
    int sum = 0;
    for (int i = 0; i < kDass21Questions.length; i++) {
      if (kDass21Questions[i].category == DassCategory.depression) {
        sum += answers[i] ?? 0;
      }
    }
    return sum * 2;
  }

  int get anxietyScore {
    int sum = 0;
    for (int i = 0; i < kDass21Questions.length; i++) {
      if (kDass21Questions[i].category == DassCategory.anxiety) {
        sum += answers[i] ?? 0;
      }
    }
    return sum * 2;
  }

  int get stressScore {
    int sum = 0;
    for (int i = 0; i < kDass21Questions.length; i++) {
      if (kDass21Questions[i].category == DassCategory.stress) {
        sum += answers[i] ?? 0;
      }
    }
    return sum * 2;
  }

  String _getCategoryLevel(int score, DassCategory cat) {
    switch (cat) {
      case DassCategory.depression:
        if (score <= 9) return 'Normal';
        if (score <= 13) return 'Ringan';
        if (score <= 20) return 'Sedang';
        if (score <= 27) return 'Parah';
        return 'Sangat Parah';
      case DassCategory.anxiety:
        if (score <= 7) return 'Normal';
        if (score <= 9) return 'Ringan';
        if (score <= 14) return 'Sedang';
        if (score <= 19) return 'Parah';
        return 'Sangat Parah';
      case DassCategory.stress:
        if (score <= 14) return 'Normal';
        if (score <= 18) return 'Ringan';
        if (score <= 25) return 'Sedang';
        if (score <= 33) return 'Parah';
        return 'Sangat Parah';
    }
  }

  Color _getLevelColor(String level) {
    switch (level) {
      case 'Normal':
        return const Color(0xFF22C55E);
      case 'Ringan':
        return const Color(0xFFEAB308);
      case 'Sedang':
        return const Color(0xFFF97316);
      case 'Parah':
      case 'Sangat Parah':
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFF3B82F6);
    }
  }

  @override
  Widget build(BuildContext context) {
    final depLevel = _getCategoryLevel(depressionScore, DassCategory.depression);
    final anxLevel = _getCategoryLevel(anxietyScore, DassCategory.anxiety);
    final strLevel = _getCategoryLevel(stressScore, DassCategory.stress);

    return Scaffold(
      backgroundColor: const Color(0xFFD9EAFD),
      body: Stack(
        children: [
          const Positioned.fill(
            child: _AssessmentBackground(),
          ),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 14),
                const Text(
                  'Hasil Asesmen Mandiri',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF061854),
                  ),
                ),
                const SizedBox(height: 14),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 480),
                        child: Column(
                          children: [
                            // Kartu Ringkasan Hasil
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(22),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(26),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF4A90D9).withValues(alpha: 0.12),
                                    blurRadius: 20,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(Icons.verified_rounded, color: Color(0xFF2B6FDE), size: 24),
                                      SizedBox(width: 8),
                                      Text(
                                        'Evaluasi DASS-21 Kamu',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16.5,
                                          fontWeight: FontWeight.w800,
                                          color: Color(0xFF061854),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  const Text(
                                    'Berikut adalah hasil pemetaan kondisi mental kamu berdasarkan 21 pertanyaan yang telah kamu isi.',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      color: Color(0xFF64748B),
                                      height: 1.4,
                                    ),
                                  ),
                                  const SizedBox(height: 18),

                                  _buildScoreRow('Tingkat Depresi', depressionScore, depLevel),
                                  const SizedBox(height: 10),
                                  _buildScoreRow('Tingkat Kecemasan', anxietyScore, anxLevel),
                                  const SizedBox(height: 10),
                                  _buildScoreRow('Tingkat Stres', stressScore, strLevel),
                                ],
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Kartu Rekomendasi Fitur Curhatin
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF4A90D9).withValues(alpha: 0.12),
                                    blurRadius: 20,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Rekomendasi Untukmu 💡',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF061854),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  _buildRecommendationTile(
                                    context: context,
                                    icon: Icons.menu_book_rounded,
                                    title: 'Tulis Refleksi di Jurnal',
                                    subtitle: 'Ekspresikan perasaanmu dengan bebas tanpa takut dinilai.',
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (_) => const JournalPage()),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  _buildRecommendationTile(
                                    context: context,
                                    icon: Icons.self_improvement_rounded,
                                    title: 'Latihan Relaksasi & Pernapasan',
                                    subtitle: 'Tarik napas dalam 4-4-4 untuk menenangkan pikiranmu.',
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (_) => const RelaxationPage()),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Tombol Kembali ke Dashboard
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (_) => const DashboardPage()),
                                    (route) => false,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF2B6FDE),
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Kembali ke Beranda',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Icon(Icons.arrow_forward_rounded, size: 18, color: Colors.white),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 28),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreRow(String title, int score, String level) {
    final color = _getLevelColor(level);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF061854),
                ),
              ),
              Text(
                'Skor: $score',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 11.5,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              level,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: const Color(0xFF2B6FDE),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF061854),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: Color(0xFF64748B), size: 20),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// DEKORASI BACKGROUND KHUSUS FITUR ASESMEN (SENADA DENGAN DASHBOARD, LOGIN, REGISTER)
// ─────────────────────────────────────────────────────────────────────────────
class _AssessmentBackground extends StatelessWidget {
  const _AssessmentBackground();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
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
    );
  }
}
