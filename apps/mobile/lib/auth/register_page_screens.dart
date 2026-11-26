import 'package:flutter/material.dart';
import '../screens/dashboard.dart';
import '../services/api_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() async {
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();
    final password = _passwordController.text;

    if (name.isEmpty) { _showSnackbar('Nama lengkap harus diisi', isError: true); return; }
    if (phone.isEmpty) { _showSnackbar('Nomor telepon harus diisi', isError: true); return; }
    if (password.isEmpty) { _showSnackbar('Password harus diisi', isError: true); return; }
    if (password.length < 6) { _showSnackbar('Password minimal 6 karakter', isError: true); return; }

    String confirmPassword = _confirmPasswordController.text;
    if (confirmPassword.isEmpty) {
      confirmPassword = password;
    } else if (password != confirmPassword) {
      _showSnackbar('Konfirmasi password tidak cocok!', isError: true);
      return;
    }

    setState(() => _isLoading = true);

    final res = await ApiService.register(
      name: name,
      phone: phone,
      password: password,
      confirmPassword: confirmPassword,
    );

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (res['success'] == true) {
      _showSnackbar(res['message'] ?? 'Pendaftaran berhasil!');
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const DashboardPage()),
            (route) => false,
          );
        }
      });
    } else {
      _showSnackbar(res['message'] ?? 'Pendaftaran gagal.', isError: true);
    }
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
    return Scaffold(
      backgroundColor: const Color(0xFFD9EAFD),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // ── BACKGROUND ─────────────────────────────────────────────
          Positioned.fill(
            child: Image.asset('assets/image/bg_bubble.jpg', fit: BoxFit.cover),
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
                        width: 40, height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.80),
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 8, offset: const Offset(0, 2))],
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
                      const Text('Curhatin', style: TextStyle(color: Color(0xFF1B6FD8), fontSize: 30, fontWeight: FontWeight.w900, letterSpacing: -1.0)),
                      const SizedBox(width: 4),
                      Container(
                        width: 24, height: 24,
                        decoration: const BoxDecoration(color: Color(0xFF1B6FD8), shape: BoxShape.circle),
                        child: const Icon(Icons.favorite_rounded, color: Colors.white, size: 14),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // ── JUDUL & SUBTITLE ───────────────────────────
                  const Text('Buat Akun Baru', style: TextStyle(color: Color(0xFF0D1B52), fontSize: 24, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 4),
                  const Text(
                    'Mulai dengan langkah kecil\nuntuk cerita yang lebih baik.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF5B84B3), fontSize: 13, height: 1.3),
                  ),

                  const SizedBox(height: 4),

                  // ── MASKOT ─────────────────────────────────────
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: SizedBox(
                        width: 70, height: 70,
                        child: Image.asset(
                          'assets/image/maskot.png',
                          fit: BoxFit.contain,
                          errorBuilder: (c, e, s) => const Icon(Icons.emoji_emotions_outlined, color: Color(0xFF2B6FDE), size: 36),
                        ),
                      ),
                    ),
                  ),

                  // ── KARTU FORM PUTIH (WRAP CONTENT) ────────────
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [BoxShadow(color: const Color(0xFF4A90D9).withOpacity(0.12), blurRadius: 24, offset: const Offset(0, 8))],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                          // Input Nama
                          _inputBox(
                            prefixIcon: Icons.person_outline_rounded,
                            child: TextField(controller: _nameController, style: _inputTextStyle, decoration: _inputDeco('Nama Lengkap')),
                          ),
                          const SizedBox(height: 10),

                          // Input Telepon
                          _phoneBox(),
                          const SizedBox(height: 10),

                          // Input Password
                          _inputBox(
                            prefixIcon: Icons.lock_outline_rounded,
                            suffixIcon: GestureDetector(
                              onTap: () => setState(() => _obscurePassword = !_obscurePassword),
                              child: Icon(_obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: const Color(0xFF6A7995), size: 20),
                            ),
                            child: TextField(controller: _passwordController, obscureText: _obscurePassword, style: _inputTextStyle, decoration: _inputDeco('Password')),
                          ),
                          const SizedBox(height: 10),

                          // Input Konfirmasi Password
                          _inputBox(
                            prefixIcon: Icons.lock_outline_rounded,
                            suffixIcon: GestureDetector(
                              onTap: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                              child: Icon(_obscureConfirmPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: const Color(0xFF6A7995), size: 20),
                            ),
                            child: TextField(controller: _confirmPasswordController, obscureText: _obscureConfirmPassword, style: _inputTextStyle, decoration: _inputDeco('Konfirmasi password')),
                          ),
                          const SizedBox(height: 16),

                          // Tombol Daftar
                          SizedBox(
                            width: double.infinity, height: 48,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _handleRegister,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2B6FDE), foregroundColor: Colors.white, elevation: 0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              ),
                              child: _isLoading
                                  ? const SizedBox(
                                      width: 22,
                                      height: 22,
                                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.2),
                                    )
                                  : const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('Daftar Sekarang', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white)),
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
                                child: Text('atau daftar dengan', style: TextStyle(color: Color(0xFF8896AB), fontSize: 11, fontWeight: FontWeight.w500)),
                              ),
                              Expanded(child: Divider(color: Color(0xFFD6DFEC), thickness: 1)),
                            ],
                          ),
                          const SizedBox(height: 10),

                          // Google
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white, borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
                            ),
                            child: const Text.rich(TextSpan(children: [
                              TextSpan(text: 'G', style: TextStyle(color: Color(0xFF4285F4), fontSize: 20, fontWeight: FontWeight.w700)),
                              TextSpan(text: 'o', style: TextStyle(color: Color(0xFFEA4335), fontSize: 20, fontWeight: FontWeight.w700)),
                              TextSpan(text: 'o', style: TextStyle(color: Color(0xFFFBBC05), fontSize: 20, fontWeight: FontWeight.w700)),
                              TextSpan(text: 'g', style: TextStyle(color: Color(0xFF4285F4), fontSize: 20, fontWeight: FontWeight.w700)),
                              TextSpan(text: 'l', style: TextStyle(color: Color(0xFF34A853), fontSize: 20, fontWeight: FontWeight.w700)),
                              TextSpan(text: 'e', style: TextStyle(color: Color(0xFFEA4335), fontSize: 20, fontWeight: FontWeight.w700)),
                            ])),
                          ),
                          const SizedBox(height: 10),

                          // Syarat & Ketentuan
                          RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                              style: TextStyle(color: Color(0xFF8896AB), fontSize: 11, height: 1.4),
                              children: [
                                TextSpan(text: 'Dengan mendaftar, kamu setuju dengan\n'),
                                TextSpan(text: 'Syarat & Ketentuan', style: TextStyle(color: Color(0xFF1B64F2), fontWeight: FontWeight.w700)),
                                TextSpan(text: ' dan '),
                                TextSpan(text: 'Kebijakan Privasi', style: TextStyle(color: Color(0xFF1B64F2), fontWeight: FontWeight.w700)),
                                TextSpan(text: ' Curhatin.'),
                              ],
                            ),
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
        color: const Color(0xFFF3F5FA), borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5EAF2), width: 1.1),
      ),
      child: Row(
        children: [
          if (prefixIcon != null) ...[const SizedBox(width: 12), Icon(prefixIcon, color: const Color(0xFF6A7995), size: 20), const SizedBox(width: 8)],
          Expanded(child: child),
          if (suffixIcon != null) ...[suffixIcon, const SizedBox(width: 10)],
        ],
      ),
    );
  }

  Widget _phoneBox() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F5FA), borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5EAF2), width: 1.1),
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: SizedBox(width: 20, height: 13, child: Column(children: [
              Expanded(child: Container(color: const Color(0xFFE53935))),
              Expanded(child: Container(color: Colors.white)),
            ])),
          ),
          const SizedBox(width: 6),
          const Text('+62', style: TextStyle(color: Color(0xFF505F79), fontSize: 14, fontWeight: FontWeight.w600)),
          const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF505F79), size: 18),
          const SizedBox(width: 6),
          Container(height: 20, width: 1, color: const Color(0xFFCBD5E1)),
          const SizedBox(width: 10),
          Expanded(child: TextField(controller: _phoneController, keyboardType: TextInputType.phone, style: _inputTextStyle, decoration: _inputDeco('Nomor telepon'))),
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
