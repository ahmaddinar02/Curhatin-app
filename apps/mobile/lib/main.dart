import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'features/relaxation/pages/relaxation_page.dart';
import 'features/forum/pages/forum_page.dart';
=======
import 'screens/landing_page_screens.dart'; // Memanggil halaman dari folder screens
>>>>>>> e9db5a0f1661678d6a64bced7fc0804604e4566e

void main() {
  runApp(const CurhatinApp());
}

class CurhatinApp extends StatelessWidget {
  const CurhatinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Curhatin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
<<<<<<< HEAD
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2B7AFC),
          brightness: Brightness.light,
=======
        useMaterial3: false,
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
        textTheme: ThemeData.light().textTheme.apply(
          fontFamily: 'Poppins',
        ),
        primaryTextTheme: ThemeData.light().primaryTextTheme.apply(
          fontFamily: 'Poppins',
>>>>>>> e9db5a0f1661678d6a64bced7fc0804604e4566e
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
<<<<<<< HEAD
      home: const RelaxationPage(),
=======
      home: const LandingPage(),
>>>>>>> e9db5a0f1661678d6a64bced7fc0804604e4566e
    );
  }
}