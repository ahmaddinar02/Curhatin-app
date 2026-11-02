import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.50, -0.00),
            end: Alignment(0.50, 1.00),
            colors: [Color(0xFF2F39A9), Color(0xFF2F39A9)],
          ),
        ),
        child: Stack(
          children: [
            // 1. Gambar latar belakang border_bawah1.png menutupi seluruh layar
            Positioned.fill(
              child: Image.asset(
                'assets/image/bordir_bawah1.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox.shrink();
                },
              ),
            ),

            // 2. Ilustrasi Wanita di Atas
            Positioned(
              top: MediaQuery.of(context).padding.top + 60,
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  width: size.width * 0.75,
                  height: size.height * 0.25,
                  child: Image.asset(
                    'assets/image/logo_hero1.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            // 3. Tombol Kembali (Panah Kiri) di Atas
            Positioned(
              left: 20,
              top: MediaQuery.of(context).padding.top + 50,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Color(0xFF2F39A9),
                    size: 20,
                  ),
                ),
              ),
            ),

            // 4. Kartu Putih Pop-Up di Tengah (Tidak memanjang sampai bawah)
            Center(
              child: SingleChildScrollView(
                child: Container(
                  width: size.width * 0.88,
                  margin: const EdgeInsets.only(top: 40),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  decoration: ShapeDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment(0.50, -0.00),
                      end: Alignment(0.50, 1.00),
                      colors: [Colors.white, Color(0xFFEFF5FD)],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32), // Membulat penuh di semua sisi
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x260A46D3),
                        blurRadius: 30,
                        offset: Offset(0, 10),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Masuk Ke Akun',
                        style: TextStyle(
                          color: Color(0xFF061854),
                          fontSize: 24,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Lanjutkan perjalanan ceritamu\nbersama Curhatin.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF808EAA),
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Input Nomor Telepon (+62)
                      Container(
                        height: 48,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF2F4FA),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              width: 1,
                              color: Color(0xFFE6EBF3),
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                children: [
                                  Text('🇮🇩', style: TextStyle(fontSize: 15)),
                                  SizedBox(width: 4),
                                  Text(
                                    '+62',
                                    style: TextStyle(
                                      color: Color(0xFF6B7893),
                                      fontSize: 13,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(width: 2),
                                  Icon(Icons.keyboard_arrow_down, color: Color(0xCC808EAA), size: 16),
                                ],
                              ),
                            ),
                            Container(
                              height: 22,
                              width: 1,
                              color: const Color(0xCC808EAA),
                            ),
                            Expanded(
                              child: TextField(
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 13,
                                  color: Color(0xFF061854),
                                ),
                                decoration: const InputDecoration(
                                  hintText: 'Nomor telefon',
                                  hintStyle: TextStyle(
                                    color: Color(0xCC808EAA),
                                    fontSize: 13,
                                    fontFamily: 'Poppins',
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Input Password
                      Container(
                        height: 48,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF2F4FA),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              width: 1,
                              color: Color(0xFFE6EBF3),
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            color: Color(0xFF061854),
                          ),
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: const TextStyle(
                              color: Color(0xCC808EAA),
                              fontSize: 13,
                              fontFamily: 'Poppins',
                            ),
                            prefixIcon: const Icon(Icons.lock_outline, color: Color(0xCC808EAA), size: 18),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                color: const Color(0xCC808EAA),
                                size: 18,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),

                      // Lupa Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(0, 26)),
                          child: const Text(
                            'Lupa password?',
                            style: TextStyle(
                              color: Color(0xFF2365F9),
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),

                      // Tombol Masuk
                      Container(
                        width: double.infinity,
                        height: 48,
                        decoration: ShapeDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment(0.00, 0.50),
                            end: Alignment(1.00, 0.50),
                            colors: [Color(0xFF499AFD), Color(0xFF216DCA)],
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x3F4648D4),
                              blurRadius: 14,
                              offset: Offset(0, 4),
                              spreadRadius: -4,
                            )
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9999),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Masuk',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.35,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                '→',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Pemisah "atau lanjut dengan"
                      Row(
                        children: [
                          const Expanded(child: Divider(color: Color(0x7FA0ABC0))),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: const Text(
                              'atau lanjut dengan',
                              style: TextStyle(
                                color: Color(0xCC808EAA),
                                fontSize: 11,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Expanded(child: Divider(color: Color(0x7FA0ABC0))),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Tombol Google
                      Container(
                        width: 115,
                        height: 38,
                        decoration: ShapeDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment(0.50, -0.00),
                            end: Alignment(0.50, 1.00),
                            colors: [Colors.white, Color(0xFFF7F7F7)],
                          ),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              width: 1,
                              color: Color(0xFFE6EBF3),
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.g_mobiledata, color: Colors.red, size: 28),
                              const SizedBox(width: 2),
                              const Text(
                                'Google',
                                style: TextStyle(
                                  color: Color(0xFF061854),
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Daftar Sekarang
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Belum punya akun? ',
                            style: TextStyle(
                              color: Color(0xCC808EAA),
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Daftar sekarang',
                              style: TextStyle(
                                color: Color(0xFF2365F9),
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}