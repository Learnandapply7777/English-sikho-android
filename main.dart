import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const EnglishSikhoApp());
}

class EnglishSikhoApp extends StatelessWidget {
  const EnglishSikhoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'English Sikho',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5426A8),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFFFFCF5),
        appBarTheme: const AppBarTheme(centerTitle: false),
      ),
      home: const HomeScreen(),
    );
  }
}
