import 'package:flutter/material.dart';
import '../theme/relaxation_theme.dart';

/// Hero section di bagian atas halaman Pojok Relaksasi.
/// Background gradient biru langit dengan ilustrasi meditasi.
class RelaxationHeroSection extends StatelessWidget {
  const RelaxationHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 220,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            RelaxationColors.heroGradientTop,
            RelaxationColors.heroGradientBottom,
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Lingkaran dekoratif di belakang
          Positioned(
            top: 20,
            right: 30,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.3),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 20,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.2),
              ),
            ),
          ),

          // Konten utama
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ilustrasi — emoji besar dengan latar meditasi
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Figur meditasi utama
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.4),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text('🧘‍♀️', style: TextStyle(fontSize: 48)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Karakter awan / pendamping
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text('☁️', style: TextStyle(fontSize: 32)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              // Tagline
              Text(
                'Temukan Ketenangan Hatimu',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: RelaxationColors.primaryDark,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Ruang aman untukmu beristirahat & pulih',
                style: TextStyle(
                  fontSize: 12,
                  color: RelaxationColors.primaryDark.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
