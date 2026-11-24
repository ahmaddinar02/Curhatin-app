import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  static const Color _bgTop = Color(0xFF2B31A0);
  static const Color _bgBottom = Color(0xFF1A1F78);
  static const Color _lightBlue = Color(0xFF7DB8FF);
  static const Color _blobLight = Color(0xFF4DB3FF);
  static const Color _blobDark = Color(0xFF1E5CE0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgBottom,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [_bgTop, _bgBottom],
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final padding = MediaQuery.of(context).padding;

            // Skala konten: muat di area aman (di luar status bar / notch).
            final availW = constraints.maxWidth;
            final availH = constraints.maxHeight - padding.top - padding.bottom;
            final s = math.min(availW / _frameW, availH / _frameH);

            // Skala blob: mengikuti lebar layar agar bentuknya sama dengan UI.
            final bs = constraints.maxWidth / _frameW;

            return Stack(
              fit: StackFit.expand,
              children: [
                // Dekorasi blob menempel di sudut layar asli
                ..._buildBlobs(bs),

                // Konten utama
                Positioned.fill(
                  child: SafeArea(
                    child: Center(
                      child: SizedBox(
                        width: _frameW * s,
                        height: _frameH * s,
                        child: _buildContent(context, s),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, double s) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // ===== Logo =====
        Positioned(
          top: _logoTop * s,
          left: 0,
          right: 0,
          child: Center(
            child: SizedBox(
              width: _logoWidth * s,
              child: Image.asset(
                'assets/images/logo_curhatin_putih.png',
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) => Text(
                  'Curhatin',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
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
          color: Colors.white54,
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
              color: Colors.white,
              fontSize: _titleSize * s,
              fontWeight: FontWeight.w500,
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
              color: _lightBlue,
              fontSize: _bodySize * s,
              fontWeight: FontWeight.w500,
              height: _bodyLineHeight,
            ),
          ),
        ),

        // ===== Tombol =====
        Positioned(
          top: _buttonTop * s,
          right: _buttonRight * s,
          child: _NextButton(scale: s, onPressed: () => _onNext(context)),
        ),
      ],
    );
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

  /// Dekorasi oval biru di pojok atas kiri, bawah kiri, dan bawah kanan layar.
  List<Widget> _buildBlobs(double s) {
    return [
      // Kiri atas
      Positioned(
        top: -34 * s,
        left: -50 * s,
        child: _Blob(width: 125 * s, height: 88 * s, angle: -0.35),
      ),
      Positioned(
        top: 18 * s,
        left: -26 * s,
        child: _Blob(width: 70 * s, height: 50 * s, angle: 0.5, opacity: 0.85),
      ),
      Positioned(
        top: 40 * s,
        left: -18 * s,
        child: _Blob(width: 46 * s, height: 56 * s, angle: 0.2, opacity: 0.9),
      ),

      // Kiri bawah
      Positioned(
        bottom: -44 * s,
        left: -70 * s,
        child: _Blob(width: 210 * s, height: 160 * s, angle: -0.35),
      ),
      Positioned(
        bottom: -14 * s,
        left: -56 * s,
        child: _Blob(width: 120 * s, height: 70 * s, angle: 0.35, opacity: 0.8),
      ),

      // Kanan bawah
      Positioned(
        bottom: -62 * s,
        right: -66 * s,
        child: _Blob(width: 195 * s, height: 135 * s, angle: 0.3),
      ),
      Positioned(
        bottom: 24 * s,
        right: -44 * s,
        child: _Blob(width: 100 * s, height: 62 * s, angle: -0.4, opacity: 0.85),
      ),
      Positioned(
        bottom: -4 * s,
        right: -26 * s,
        child: _Blob(width: 86 * s, height: 70 * s, angle: 0.2, opacity: 0.7),
      ),
    ];
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

class _Blob extends StatelessWidget {
  final double width;
  final double height;
  final double angle;
  final double opacity;

  const _Blob({
    required this.width,
    required this.height,
    this.angle = 0,
    this.opacity = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Transform.rotate(
        angle: angle,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.elliptical(width, height)),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AssessmentIntroPage._blobLight,
                AssessmentIntroPage._blobDark,
              ],
            ),
          ),
        ),
      ),
    );
  }
}