import 'package:flutter/material.dart';
import 'features/relaxation/pages/relaxation_page.dart';
import 'features/forum/pages/forum_page.dart';

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
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2B7AFC),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const RelaxationPage(),
    );
  }
}
