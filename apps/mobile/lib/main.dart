import 'package:flutter/material.dart';
import 'auth/landing_page_screens.dart';

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
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2B7AFC),
          brightness: Brightness.light,
        ),
        fontFamily: 'Poppins',
        textTheme: ThemeData.light().textTheme.apply(
          fontFamily: 'Poppins',
        ),
        primaryTextTheme: ThemeData.light().primaryTextTheme.apply(
          fontFamily: 'Poppins',
        ),
      ),
      home: const LandingPage(),
    );
  }
}
