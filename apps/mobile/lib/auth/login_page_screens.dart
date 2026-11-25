import 'package:flutter/material.dart';
import 'register_page_screens.dart';
import 'forgot_password_screens.dart';
import '../features/journal/journal_page_screens.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showSnackbar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(fontWeight: FontWeight.w500)),
        backgroundColor: isError ? const Color(0xFFE53935) : const Color(0xFF2B70E4),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFD9EAFD),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // ── BACKGROUND ─────────────────────────────────────────────
          Positioned.fill(
            child: Image.asset(
              'assets/image/bg_bubble.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // ── KONTEN FIXED ───────────────────────────────────────────
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 8),

                  // ── TOMBOL BACK ────────────────────────────────
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.maybePop(context),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.80),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.07),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.arrow_back, color: Color(0xFF6B8AB8), size: 20),
                      ),
                    ),
                  ),

                  const SizedBox(height: 6),

                  // ── LOGO CURHATIN ──────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Curhatin',
                        style: TextStyle(
                          color: Color(0xFF1B6FD8),
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -1.0,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        width: 26,
                        height: 26,
                        decoration: const BoxDecoration(color: Color(0xFF1B6FD8), shape: BoxShape.circle),
                        child: const Icon(Icons.favorite_rounded, color: Colors.white, size: 15),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // ── ILUSTRASI ──────────────────────────────────
                  SizedBox(
                    width: size.width * 0.65,
                    height: size.height * 0.20,
                    child: Image.asset(
                      'assets/image/logo_hero1.png',
                      fit: BoxFit.contain,
                      alignment: Alignment.bottomCenter,
                      errorBuilder: (c, e, s) => const SizedBox.shrink(),
                    ),
                  ),

                  const SizedBox(height: 6),

                  // ── KARTU PUTIH FORM (WRAP CONTENT) ────────────
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF4A90D9).withOpacity(0.12),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                          const Text(
                            'Masuk Ke Akun',
                            style: TextStyle(color: Color(0xFF061854), fontSize: 22, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 3),
                          const Text(
                            'Lanjutkan perjalanan ceritamu\nbersama Curhatin.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Color(0xFF808EAA), fontSize: 12, height: 1.4),
                          ),
                          const SizedBox(height: 14),

                          // Input Nomor Telepon
                          _phoneBox(),
                          const SizedBox(height: 10),

                          // Input Password
                          _inputBox(
                            prefixIcon: Icons.lock_outline_rounded,
                            suffixIcon: GestureDetector(
                              onTap: () => setState(() => _obscurePassword = !_obscurePassword),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Icon(
                                  _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                  color: const Color(0xFF6A7995), size: 20,
                                ),
                              ),
                            ),
                            child: TextField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              style: _inputTextStyle,
                              decoration: _inputDeco('Password'),
                            ),
                          ),

                          // Lupa Password
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => const ForgotPasswordPage()));
                              },
                              style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(0, 28)),
                              child: const Text(
                                'Lupa password?',
                                style: TextStyle(color: Color(0xFF2365F9), fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),

                          const SizedBox(height: 2),

                          // Tombol Masuk
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => const JournalPage()),
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
                                  Text('Masuk', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700)),
                                  SizedBox(width: 8),
                                  Icon(Icons.arrow_forward_rounded, size: 18, color: Colors.white),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Divider
                          const Row(
                            children: [
                              Expanded(child: Divider(color: Color(0xFFD6DFEC), thickness: 1)),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text('atau lanjut dengan', style: TextStyle(color: Color(0xFF8896AB), fontSize: 11, fontWeight: FontWeight.w500)),
                              ),
                              Expanded(child: Divider(color: Color(0xFFD6DFEC), thickness: 1)),
                            ],
                          ),
                          const SizedBox(height: 10),

                          // Tombol Google
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
                            ),
                            child: const Text.rich(
                              TextSpan(children: [
                                TextSpan(text: 'G', style: TextStyle(color: Color(0xFF4285F4), fontSize: 20, fontWeight: FontWeight.w700)),
                                TextSpan(text: 'o', style: TextStyle(color: Color(0xFFEA4335), fontSize: 20, fontWeight: FontWeight.w700)),
                                TextSpan(text: 'o', style: TextStyle(color: Color(0xFFFBBC05), fontSize: 20, fontWeight: FontWeight.w700)),
                                TextSpan(text: 'g', style: TextStyle(color: Color(0xFF4285F4), fontSize: 20, fontWeight: FontWeight.w700)),
                                TextSpan(text: 'l', style: TextStyle(color: Color(0xFF34A853), fontSize: 20, fontWeight: FontWeight.w700)),
                                TextSpan(text: 'e', style: TextStyle(color: Color(0xFFEA4335), fontSize: 20, fontWeight: FontWeight.w700)),
                              ]),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Daftar sekarang
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Belum punya akun? ', style: TextStyle(color: Color(0xFF808EAA), fontSize: 12)),
                              GestureDetector(
                                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterPage())),
                                child: const Text('Daftar sekarang', style: TextStyle(color: Color(0xFF2365F9), fontSize: 12, fontWeight: FontWeight.w700)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── HELPERS ──────────────────────────────────────────────────────

  Widget _inputBox({required Widget child, IconData? prefixIcon, Widget? suffixIcon}) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F5FA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5EAF2), width: 1.1),
      ),
      child: Row(
        children: [
          if (prefixIcon != null) ...[
            const SizedBox(width: 12),
            Icon(prefixIcon, color: const Color(0xFF6A7995), size: 20),
            const SizedBox(width: 8),
          ],
          Expanded(child: child),
          if (suffixIcon != null) suffixIcon,
        ],
      ),
    );
  }

  Widget _phoneBox() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F5FA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5EAF2), width: 1.1),
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: SizedBox(
              width: 20, height: 13,
              child: Column(children: [
                Expanded(child: Container(color: const Color(0xFFE53935))),
                Expanded(child: Container(color: Colors.white)),
              ]),
            ),
          ),
          const SizedBox(width: 6),
          const Text('+62', style: TextStyle(color: Color(0xFF505F79), fontSize: 14, fontWeight: FontWeight.w600)),
          const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF505F79), size: 18),
          const SizedBox(width: 6),
          Container(height: 20, width: 1, color: const Color(0xFFCBD5E1)),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              style: _inputTextStyle,
              decoration: _inputDeco('Nomor telepon'),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDeco(String hint) => InputDecoration(
    isDense: true, hintText: hint,
    hintStyle: const TextStyle(color: Color(0xFF909EB5), fontSize: 14),
    border: InputBorder.none,
    contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 15),
  );

  static const TextStyle _inputTextStyle = TextStyle(color: Color(0xFF2C3E50), fontSize: 14);
}
