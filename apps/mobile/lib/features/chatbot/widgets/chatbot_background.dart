import 'package:flutter/material.dart';
import '../theme/chatbot_theme.dart';

/// Latar belakang gradasi biru muda dengan gelembung & awan lembut
/// sesuai referensi desain halaman Chatbot Athena.
class ChatbotBackground extends StatelessWidget {
  final Widget child;

  const ChatbotBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Dasar gradasi putih-biru lembut
        Positioned.fill(
          child: DecoratedBox(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  ChatbotColors.backgroundTop,
                  ChatbotColors.backgroundBottom,
                  Color(0xFFEDF5FF),
                ],
                stops: [0.0, 0.55, 1.0],
              ),
            ),
          ),
        ),

        // Gelembung dekoratif kiri atas
        Positioned(
          top: -35,
          left: -45,
          child: _SoftBubble(size: 185, opacity: 0.34),
        ),
        Positioned(
          top: 75,
          left: -25,
          child: _SoftBubble(size: 120, opacity: 0.24),
        ),

        // Gelembung dekoratif kanan atas
        Positioned(
          top: -20,
          right: -50,
          child: _SoftBubble(size: 200, opacity: 0.32),
        ),
        Positioned(
          top: 125,
          right: -30,
          child: _SoftBubble(size: 135, opacity: 0.22),
        ),

        // Awan putih lembut di tengah belakang karakter
        Positioned(
          top: 195,
          left: -40,
          child: _SoftCloud(width: 190, height: 120),
        ),
        Positioned(
          top: 210,
          right: -35,
          child: _SoftCloud(width: 180, height: 115),
        ),

        // Gelembung dekoratif bawah layar
        Positioned(
          bottom: -55,
          left: -45,
          child: _SoftBubble(size: 195, opacity: 0.36),
        ),
        Positioned(
          bottom: -70,
          left: 85,
          child: _SoftBubble(size: 165, opacity: 0.24),
        ),
        Positioned(
          bottom: -45,
          right: -45,
          child: _SoftBubble(size: 205, opacity: 0.38),
        ),

        child,
      ],
    );
  }
}

class _SoftBubble extends StatelessWidget {
  final double size;
  final double opacity;

  const _SoftBubble({required this.size, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            center: const Alignment(-0.25, -0.25),
            radius: 0.85,
            colors: [
              Colors.white.withValues(alpha: opacity * 0.45),
              ChatbotColors.bubbleLight.withValues(alpha: opacity),
              ChatbotColors.bubbleMid.withValues(alpha: opacity * 0.85),
            ],
          ),
        ),
      ),
    );
  }
}

class _SoftCloud extends StatelessWidget {
  final double width;
  final double height;

  const _SoftCloud({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(height),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white.withValues(alpha: 0.72),
              Colors.white.withValues(alpha: 0.15),
            ],
          ),
        ),
      ),
    );
  }
}
