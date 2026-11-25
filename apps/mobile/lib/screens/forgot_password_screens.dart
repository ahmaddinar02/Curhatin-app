import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _codeSent = false;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
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

  void _handleSendCode() {
    if (_phoneController.text.trim().isEmpty) {
      _showSnackbar('Nomor telepon harus diisi', isError: true);
      return;
    }
    setState(() => _codeSent = true);
    _showSnackbar('Kode verifikasi telah dikirim');
  }

  void _handleResetPassword() {
    if (_codeController.text.trim().isEmpty) { _showSnackbar('Kode verifikasi harus diisi', isError: true); return; }
    if (_newPasswordController.text.isEmpty) { _showSnackbar('Password baru harus diisi', isError: true); return; }
    if (_newPasswordController.text.length < 6) { _showSnackbar('Password minimal 6 karakter', isError: true); return; }
    if (_newPasswordController.text != _confirmPasswordController.text) { _showSnackbar('Konfirmasi password tidak cocok!', isError: true); return; }
    _showSnackbar('Password berhasil diubah!');
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) Navigator.pop(context);
    });
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
                      const Text('Curhatin', style: TextStyle(color: Color(0xFF1B6FD8), fontSize: 32, fontWeight: FontWeight.w900, letterSpacing: -1.0)),
                      const SizedBox(width: 4),
                      Container(
                        width: 26, height: 26,
                        decoration: const BoxDecoration(color: Color(0xFF1B6FD8), shape: BoxShape.circle),
                        child: const Icon(Icons.favorite_rounded, color: Colors.white, size: 15),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // ── IKON KUNCI ─────────────────────────────────
                  Container(
                    width: 72, height: 72,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDF3FF),
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: const Color(0xFF4A90D9).withOpacity(0.12), blurRadius: 20, offset: const Offset(0, 6))],
                    ),
                    child: const Icon(Icons.lock_reset_rounded, color: Color(0xFF2B6FDE), size: 36),
                  ),

                  const SizedBox(height: 16),

                  // ── KARTU PUTIH FORM (WRAP CONTENT) ────────────
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [BoxShadow(color: const Color(0xFF4A90D9).withOpacity(0.12), blurRadius: 24, offset: const Offset(0, 8))],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Judul
                        const Text('Lupa Kata Sandi', style: TextStyle(color: Color(0xFF061854), fontSize: 22, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 6),
                        Text(
                          _codeSent
                              ? 'Masukkan kode verifikasi dan\npassword baru kamu.'
                              : 'Masukkan nomor telepon yang terdaftar\nuntuk menerima kode verifikasi.',
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Color(0xFF808EAA), fontSize: 12.5, height: 1.4),
                        ),
                        const SizedBox(height: 24),

                        if (!_codeSent) ...[
                          // ── STEP 1: INPUT NOMOR TELEPON ──────
                          _phoneBox(),
                          const SizedBox(height: 20),

                          // ── KELOMPOK TOMBOL & TEKS KEMBALI ───
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _handleSendCode,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2B6FDE),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Kirim Kode Verifikasi', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white)),
                                  SizedBox(width: 8),
                                  Icon(Icons.arrow_forward_rounded, size: 18, color: Colors.white),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.arrow_back_rounded, color: Color(0xFF808EAA), size: 16),
                                SizedBox(width: 6),
                                Text(
                                  'Kembali ke halaman login',
                                  style: TextStyle(color: Color(0xFF808EAA), fontSize: 13, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ] else ...[
                          // ── STEP 2: KODE + PASSWORD BARU ─────
                          _inputBox(
                            prefixIcon: Icons.pin_outlined,
                            child: TextField(controller: _codeController, keyboardType: TextInputType.number, style: _inputTextStyle, decoration: _inputDeco('Kode Verifikasi')),
                          ),
                          const SizedBox(height: 10),

                          _inputBox(
                            prefixIcon: Icons.lock_outline_rounded,
                            suffixIcon: GestureDetector(
                              onTap: () => setState(() => _obscureNew = !_obscureNew),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Icon(_obscureNew ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: const Color(0xFF6A7995), size: 20),
                              ),
                            ),
                            child: TextField(controller: _newPasswordController, obscureText: _obscureNew, style: _inputTextStyle, decoration: _inputDeco('Password baru')),
                          ),
                          const SizedBox(height: 10),

                          _inputBox(
                            prefixIcon: Icons.lock_outline_rounded,
                            suffixIcon: GestureDetector(
                              onTap: () => setState(() => _obscureConfirm = !_obscureConfirm),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Icon(_obscureConfirm ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: const Color(0xFF6A7995), size: 20),
                              ),
                            ),
                            child: TextField(controller: _confirmPasswordController, obscureText: _obscureConfirm, style: _inputTextStyle, decoration: _inputDeco('Konfirmasi password baru')),
                          ),

                          const SizedBox(height: 18),

                          // ── KELOMPOK TOMBOL & TEKS ────────────
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _handleResetPassword,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2B6FDE),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Ubah Password', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white)),
                                  SizedBox(width: 8),
                                  Icon(Icons.check_circle_outline_rounded, size: 18, color: Colors.white),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Kirim ulang kode
                          GestureDetector(
                            onTap: () => _showSnackbar('Kode verifikasi telah dikirim ulang'),
                            child: const Text('Kirim ulang kode', style: TextStyle(color: Color(0xFF2365F9), fontSize: 13, fontWeight: FontWeight.w600)),
                          ),
                          const SizedBox(height: 12),

                          // Kembali ke login
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.arrow_back_rounded, color: Color(0xFF808EAA), size: 16),
                                SizedBox(width: 6),
                                Text('Kembali ke halaman login', style: TextStyle(color: Color(0xFF808EAA), fontSize: 13, fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  const Spacer(),
                  const SizedBox(height: 12),
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
          if (suffixIcon != null) suffixIcon,
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
