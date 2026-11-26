import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Halaman persiapan asesmen Curhatin (frame desain "LP AM2").
///
/// Semua elemen diposisikan ABSOLUT memakai satuan "px frame desain"
/// 354 x 769 (hasil ukur langsung dari gambar UI), lalu diskalakan ke layar.
/// Jadi layout-nya sama persis dengan desain di semua ukuran HP.
///
/// Asset (assets/images/), daftarkan di pubspec.yaml:
///   logo_curhatin_putih.png -> logo di atas
///   assesment_logo2.png     -> maskot pose bertopang dagu (PNG transparan)
///   assessment_bg.png       -> (OPSIONAL, DISARANKAN) background blob hasil
///                              ekspor dari desain tanpa konten. Kalau file
///                              ini ada, dipakai langsung sehingga blob 100%
///                              sama dengan desain. Kalau tidak ada, blob
///                              digambar lewat kode (pendekatan).
class AssessmentPreparePage extends StatelessWidget {
  const AssessmentPreparePage({super.key});

  // ---- Frame desain ----
  static const double _frameW = 354;
  static const double _frameH = 769;

  // ---- Logo & maskot ----
  static const double _logoTop = 14;
  static const double _logoWidth = 167;

  static const double _mascotTop = 72;
  static const double _mascotHeight = 85;
  static const double _mascotOffsetX = 8; // + kanan, - kiri

  // ---- Kartu (x = 24, lebar = 316) ----
  static const double _cardLeft = 24;
  static const double _cardWidth = 316;

  // ---- Tombol ----
  static const double _buttonTop = 604;
  static const double _buttonHeight = 36;

  // ---- Warna ----
  static const Color _bgTop = Color(0xFF2B31A0);
  static const Color _bgBottom = Color(0xFF1A1F78);
  static const Color _iconBlue = Color(0xFF2A7BFF);
  static const Color _textDark = Color(0xFF111111);
  static const Color _textGrey = Color(0xFF3C3C3C);

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
            final availW = constraints.maxWidth;
            final availH = constraints.maxHeight - padding.top - padding.bottom;
            final s = math.min(availW / _frameW, availH / _frameH);
            final bs = constraints.maxWidth / _frameW;

            return Stack(
              fit: StackFit.expand,
              children: [
                // Background blob
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/assessment_bg.png',
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    errorBuilder: (_, _, _) => _PaintedBlobs(scale: bs),
                  ),
                ),

                // Konten
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
                    fontSize: 30 * s,
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
          height: _mascotHeight * s,
          child: Transform.translate(
            offset: Offset(_mascotOffsetX * s, 0),
            child: Image.asset(
              'assets/images/assesment_logo2.png',
              height: _mascotHeight * s,
              fit: BoxFit.contain,
              alignment: Alignment.center,
              errorBuilder: (_, _, _) =>
                  Icon(Icons.person, size: 70 * s, color: Colors.white54),
            ),
          ),
        ),

        // ===== Kartu 1 : Sepenuhnya Rahasia =====
        _card(
          s: s,
          top: 167,
          height: 81,
          children: [
            _circleIcon(s, left: 12, top: 14, icon: Icons.lock_rounded),
            _text(
              s,
              left: 56,
              top: 13,
              text: 'Sepenuhnya Rahasia',
              style: GoogleFonts.poppins(
                fontSize: 11 * s,
                fontWeight: FontWeight.w600,
                color: _textDark,
                height: 1.3,
              ),
            ),
            _text(
              s,
              left: 56,
              top: 31,
              text:
                  'Jawaban dan datamu tersimpan aman,\nterenkripsi, dan hanya untuk perjalanan\nrefleksi pribadimu.',
              style: GoogleFonts.poppins(
                fontSize: 8.5 * s,
                fontWeight: FontWeight.w400,
                color: _textGrey,
                height: 1.7,
              ),
            ),
          ],
        ),

        // ===== Kartu 2 : Waktu Singkat =====
        _card(
          s: s,
          top: 256,
          height: 82,
          children: [
            _circleIcon(s, left: 12, top: 10, icon: Icons.timer_outlined),
            _text(
              s,
              left: 56,
              top: 14,
              text: 'Waktu Singkat (3–5 Menit)',
              style: GoogleFonts.poppins(
                fontSize: 11 * s,
                fontWeight: FontWeight.w600,
                color: _textDark,
                height: 1.3,
              ),
            ),
            _text(
              s,
              left: 56,
              top: 32,
              text:
                  'Cukup 21 pertanyaan sederhana yang bisa\nkamu jawab perlahan sesuai ritme dan\nkenyamananmu.',
              style: GoogleFonts.poppins(
                fontSize: 8.5 * s,
                fontWeight: FontWeight.w400,
                color: _textGrey,
                height: 1.7,
              ),
            ),
          ],
        ),

        // ===== Kartu 3 : Tanpa Tekanan =====
        _card(
          s: s,
          top: 349,
          height: 86,
          children: [
            _circleIcon(s, left: 12, top: 15, icon: Icons.spa_outlined),
            _text(
              s,
              left: 56,
              top: 14,
              text: 'Tanpa Tekanan',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13 * s,
                fontWeight: FontWeight.w500,
                color: _textDark,
                height: 1.3,
              ),
            ),
            _text(
              s,
              left: 56,
              top: 33,
              text:
                  'Bukan untuk menghakimi atau memberi cap,\nmelainkan langkah awal memahami apa yang\nsedang kamu rasakan.',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 10.5 * s,
                fontWeight: FontWeight.w400,
                color: _textDark,
                height: 1.35,
              ),
            ),
          ],
        ),

        // ===== Kartu 4 : Sebelum Memulai =====
        _card(
          s: s,
          top: 443,
          height: 126,
          children: [
            Positioned(
              left: 16 * s,
              top: 16 * s,
              child: Icon(
                Icons.self_improvement_rounded,
                size: 15 * s,
                color: _textDark,
              ),
            ),
            _text(
              s,
              left: 34,
              top: 15,
              text: 'Sebelum Memulai',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13 * s,
                fontWeight: FontWeight.w500,
                color: _textDark,
                height: 1.3,
              ),
            ),

            // Langkah 1
            _stepCircle(s, top: 42, number: 1),
            _stepText(s, top: 43, text: 'Cari posisi duduk yang santai dan nyaman'),

            // Langkah 2
            _stepCircle(s, top: 63, number: 2),
            _stepText(
              s,
              top: 59,
              text: 'Tarik napas dalam sejenak, lepaskan\nketegangan bahu',
            ),

            // Langkah 3
            _stepCircle(s, top: 93, number: 3),
            _stepText(
              s,
              top: 87,
              text: 'Jawablah jujur sesuai perasaanmu dalam 2\nminggu terakhir',
            ),
          ],
        ),

        // ===== Tombol Kembali =====
        Positioned(
          top: _buttonTop * s,
          left: 24 * s,
          child: _GradientButton(
            scale: s,
            width: 96,
            height: _buttonHeight,
            label: 'Kembali',
            icon: Icons.arrow_back_rounded,
            iconFirst: true,
            onPressed: () => Navigator.maybePop(context),
          ),
        ),

        // ===== Tombol Mulai =====
        Positioned(
          top: _buttonTop * s,
          left: 236 * s,
          child: _GradientButton(
            scale: s,
            width: 94,
            height: _buttonHeight,
            label: 'Mulai',
            icon: Icons.arrow_forward_rounded,
            iconFirst: false,
            onPressed: _onStart,
          ),
        ),
      ],
    );
  }

  static void _onStart() {
    // TODO: navigasi ke halaman pertanyaan asesmen.
  }

  // ------------------------------------------------------------------
  // Helper layout (semua koordinat dalam px frame desain)
  // ------------------------------------------------------------------

  /// Kartu putih. Koordinat anak-anaknya relatif terhadap pojok kiri atas kartu.
  Widget _card({
    required double s,
    required double top,
    required double height,
    required List<Widget> children,
  }) {
    return Positioned(
      top: top * s,
      left: _cardLeft * s,
      width: _cardWidth * s,
      height: height * s,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16 * s),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.14),
              blurRadius: 8 * s,
              offset: Offset(0, 3 * s),
            ),
          ],
        ),
        child: Stack(clipBehavior: Clip.none, children: children),
      ),
    );
  }

  Widget _circleIcon(
    double s, {
    required double left,
    required double top,
    required IconData icon,
  }) {
    return Positioned(
      left: left * s,
      top: top * s,
      child: Container(
        width: 32 * s,
        height: 32 * s,
        decoration: const BoxDecoration(
          color: _iconBlue,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 16 * s),
      ),
    );
  }

  Widget _text(
    double s, {
    required double left,
    required double top,
    required String text,
    required TextStyle style,
  }) {
    return Positioned(
      left: left * s,
      top: top * s,
      child: Text(
        text,
        style: style.copyWith(
          leadingDistribution: TextLeadingDistribution.even,
        ),
      ),
    );
  }

  Widget _stepCircle(double s, {required double top, required int number}) {
    return Positioned(
      left: 17 * s,
      top: top * s,
      child: Container(
        width: 16 * s,
        height: 16 * s,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Color(0xFFEBEBEB),
          shape: BoxShape.circle,
        ),
        child: Text(
          '$number',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 8 * s,
            fontWeight: FontWeight.w500,
            color: _textDark,
          ),
        ),
      ),
    );
  }

  Widget _stepText(double s, {required double top, required String text}) {
    return _text(
      s,
      left: 42,
      top: top,
      text: text,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 10.5 * s,
        fontWeight: FontWeight.w400,
        color: _textDark,
        height: 1.35,
      ),
    );
  }
}

// ======================================================================
// Tombol gradasi biru (Kembali / Mulai)
// ======================================================================
class _GradientButton extends StatelessWidget {
  final double scale;
  final double width;
  final double height;
  final String label;
  final IconData icon;
  final bool iconFirst;
  final VoidCallback onPressed;

  const _GradientButton({
    required this.scale,
    required this.width,
    required this.height,
    required this.label,
    required this.icon,
    required this.iconFirst,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final s = scale;
    final iconWidget = Icon(icon, color: Colors.white, size: 15 * s);
    final textWidget = Text(
      label,
      style: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 11 * s,
        fontWeight: FontWeight.w600,
      ),
    );

    return Container(
      width: width * s,
      height: height * s,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30 * s),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF4BA3FF), Color(0xFF2A6FE8)],
        ),
        boxShadow: [
          // Tebal gelap di bawah tombol (efek 3D seperti di desain)
          BoxShadow(
            color: const Color(0xFF1B3FB8).withValues(alpha: 0.9),
            blurRadius: 4 * s,
            offset: Offset(0, 5 * s),
          ),
          // Glow biru
          BoxShadow(
            color: const Color(0xFF3B9BFF).withValues(alpha: 0.45),
            blurRadius: 14 * s,
            offset: Offset(0, 2 * s),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30 * s),
          onTap: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: iconFirst
                ? [iconWidget, SizedBox(width: 7 * s), textWidget]
                : [textWidget, SizedBox(width: 7 * s), iconWidget],
          ),
        ),
      ),
    );
  }
}

// ======================================================================
// Fallback: blob digambar lewat kode (dipakai bila assessment_bg.png tidak ada)
// Koordinat dalam px frame desain; menempel di sudut layar asli.
// ======================================================================
class _PaintedBlobs extends StatelessWidget {
  final double scale;

  const _PaintedBlobs({required this.scale});

  @override
  Widget build(BuildContext context) {
    final s = scale;
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        // ---------- Kiri atas ----------
        _tl(s, cx: 42, cy: 8, w: 140, h: 72, angle: 0.35),
        _tl(s, cx: 30, cy: 34, w: 76, h: 40, angle: 0.65, opacity: 0.95),
        _tl(s, cx: 8, cy: 66, w: 84, h: 30, angle: 1.1),

        // ---------- Kiri bawah ----------
        _bl(s, cx: 14, cy: 112, w: 104, h: 40, angle: 1.05),
        _bl(s, cx: 20, cy: 58, w: 120, h: 62, angle: 0.55, opacity: 0.95),
        _bl(s, cx: 110, cy: 20, w: 270, h: 118, angle: -0.14),

        // ---------- Kanan bawah ----------
        _br(s, cx: 22, cy: 104, w: 104, h: 48, angle: -0.95),
        _br(s, cx: 14, cy: 58, w: 124, h: 58, angle: -0.5, opacity: 0.95),
        _br(s, cx: 86, cy: 18, w: 260, h: 112, angle: 0.18),
      ],
    );
  }

  Widget _tl(double s,
      {required double cx,
      required double cy,
      required double w,
      required double h,
      required double angle,
      double opacity = 1}) {
    return Positioned(
      left: (cx - w / 2) * s,
      top: (cy - h / 2) * s,
      child: _Blob(width: w * s, height: h * s, angle: angle, opacity: opacity),
    );
  }

  Widget _bl(double s,
      {required double cx,
      required double cy,
      required double w,
      required double h,
      required double angle,
      double opacity = 1}) {
    return Positioned(
      left: (cx - w / 2) * s,
      bottom: (cy - h / 2) * s,
      child: _Blob(width: w * s, height: h * s, angle: angle, opacity: opacity),
    );
  }

  Widget _br(double s,
      {required double cx,
      required double cy,
      required double w,
      required double h,
      required double angle,
      double opacity = 1}) {
    return Positioned(
      right: (cx - w / 2) * s,
      bottom: (cy - h / 2) * s,
      child: _Blob(width: w * s, height: h * s, angle: angle, opacity: opacity),
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
            borderRadius: BorderRadius.all(
              Radius.elliptical(width / 2, height / 2),
            ),
            gradient: const RadialGradient(
              center: Alignment(-0.55, -0.65),
              radius: 1.05,
              colors: [
                Color(0xFFC4E6FF),
                Color(0xFF47A0FF),
                Color(0xFF1D52E0),
              ],
              stops: [0.0, 0.42, 1.0],
            ),
          ),
        ),
      ),
    );
  }
}