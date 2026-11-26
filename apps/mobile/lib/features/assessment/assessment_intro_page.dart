import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../screens/dashboard.dart';
import 'assessment_prepare_page.dart';

/// Halaman pembuka asesmen Curhatin (frame desain "LP AM1").
///
/// Semua posisi dan ukuran memakai satuan "px frame desain" 293 x 627
/// (hasil ukur dari gambar UI). Konten diskalakan agar muat di area aman
/// layar dan diletakkan di tengah. Blob dekorasi menempel di sudut layar
/// asli, jadi tampilannya tetap sama dengan UI di semua ukuran HP.
///
/// Asset (assets/images/), daftarkan di pubspec.yaml:
///   logo_curhatin_putih.png  -> logo di atas
///   assesment_logo1.png      -> maskot karakter (PNG transparan)
class AssessmentIntroPage extends StatelessWidget {
  const AssessmentIntroPage({super.key});

  // ---- Ukuran frame desain acuan ----
  static const double _frameW = 293;
  static const double _frameH = 627;

  // ---- Posisi & ukuran (px frame desain) ----
  // Logo
  static const double _logoTop = 8;
  static const double _logoWidth = 138;

  // Maskot
  static const double _mascotTop = 143;
  static const double _mascotHeight = 160;
  static const double _mascotOffsetX = 30; // + geser kanan, - geser kiri

  // Judul
  static const double _titleTop = 318;
  static const double _titleSize = 14.5;
  static const double _titleLineHeight = 1.5;

  // Deskripsi
  static const double _bodyTop = 364;
  static const double _bodySize = 9.5;
  static const double _bodyLineHeight = 1.58;

  // Tombol
  static const double _buttonTop = 502;
  static const double _buttonRight = 19;

  // ---- Warna ----
  static const Color _bg = Color(0xFFD9EAFD);
  static const Color _textNavy = Color(0xFF061854);
  static const Color _textGrey = Color(0xFF475569);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background senada dashboard, login, dan register
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

          // Konten utama
          LayoutBuilder(
            builder: (context, constraints) {
              final padding = MediaQuery.of(context).padding;

              // Skala konten: muat di area aman (di luar status bar / notch).
              final availW = constraints.maxWidth;
              final availH = constraints.maxHeight - padding.top - padding.bottom;
              final s = math.min(availW / _frameW, availH / _frameH);

              return SafeArea(
                child: Center(
                  child: SizedBox(
                    width: _frameW * s,
                    height: _frameH * s,
                    child: _buildContent(context, s),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, double s) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // ===== Tombol Kembali ke Beranda (Atas Kiri) =====
        Positioned(
          top: (_logoTop - 2) * s,
          left: 4 * s,
          child: GestureDetector(
            onTap: () => _popToHome(context),
            child: Container(
              width: 34 * s,
              height: 34 * s,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF4A90D9).withValues(alpha: 0.16),
                    blurRadius: 8 * s,
                    offset: Offset(0, 2 * s),
                  ),
                ],
              ),
              child: Icon(
                Icons.arrow_back_rounded,
                color: const Color(0xFF2B6FDE),
                size: 18 * s,
              ),
            ),
          ),
        ),

        // ===== Logo =====
        Positioned(
          top: _logoTop * s,
          left: 0,
          right: 0,
          child: Center(
            child: SizedBox(
              width: _logoWidth * s,
              child: Image.asset(
                'assets/images/curhatinlogo2.png',
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) => Text(
                  'Curhatin',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF1B6FD8),
                    fontSize: 28 * s,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),

        // ===== Maskot =====
Positioned(
  top: _mascotTop * s,
  left: 0,
  right: 0,
  child: SizedBox(
    width: _frameW * s,
    height: _mascotHeight * s,
    child: Transform.translate(
      offset: Offset(_mascotOffsetX * s, 0),
      child: Image.asset(
        'assets/images/assesment_logo1.png',
        height: _mascotHeight * s,
        fit: BoxFit.contain,
        alignment: Alignment.center,
        errorBuilder: (_, _, _) => Icon(
          Icons.person,
          size: 120 * s,
          color: const Color(0xFF2B6FDE),
        ),
      ),
    ),
  ),
),

        // ===== Judul =====
        Positioned(
          top: _titleTop * s,
          left: 0,
          right: 0,
          child: Text(
            'Ambil jeda sejenak.\nCeritakan kabarmu hari ini.',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: _textNavy,
              fontSize: _titleSize * s,
              fontWeight: FontWeight.w700,
              height: _titleLineHeight,
            ),
          ),
        ),

        // ===== Deskripsi =====
        Positioned(
          top: _bodyTop * s,
          left: 0,
          right: 0,
          child: Text(
            'Tidak ada jawaban yang benar atau salah.\n'
            'Asesmen ini hadir untuk membantumu mengenali\n'
            'kondisi perasaan dan kebutuhan batinmu saat ini.',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: _textGrey,
              fontSize: _bodySize * s,
              fontWeight: FontWeight.w500,
              height: _bodyLineHeight,
            ),
          ),
        ),

        // ===== Tombol Selanjutnya =====
        Positioned(
          top: _buttonTop * s,
          right: _buttonRight * s,
          child: _NextButton(scale: s, onPressed: () => _onNext(context)),
        ),
      ],
    );
  }

  /// Kembali ke halaman Beranda / Dashboard.
  static void _popToHome(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardPage()),
      );
    }
  }

  /// Pindah ke halaman persiapan asesmen dengan transisi geser + fade.
  static void _onNext(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 350),
        pageBuilder: (_, _, _) => const AssessmentPreparePage(),
        transitionsBuilder: (_, animation, _, child) {
          final curved = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          );
          return FadeTransition(
            opacity: curved,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.08, 0),
                end: Offset.zero,
              ).animate(curved),
              child: child,
            ),
          );
        },
      ),
    );
  }
}

class _NextButton extends StatelessWidget {
  final double scale;
  final VoidCallback onPressed;

  const _NextButton({required this.scale, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final s = scale;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30 * s),
        gradient: const LinearGradient(
          colors: [Color(0xFF3B9BFF), Color(0xFF2A6FE8)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B9BFF).withValues(alpha: 0.5),
            blurRadius: 12 * s,
            offset: Offset(0, 4 * s),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30 * s),
          onTap: onPressed,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 13 * s, vertical: 7.5 * s),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Selanjutnya',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 9 * s,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 5 * s),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                  size: 11 * s,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}