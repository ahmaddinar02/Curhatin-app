import 'package:flutter/material.dart';
import 'screens/landing_page_screens.dart';
import 'features/forum/pages/forum_page.dart'; // Forum dari branch dinar

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
        useMaterial3: false,
        primarySwatch: Colors.blue,
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