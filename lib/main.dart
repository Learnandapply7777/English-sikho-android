import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

// App build verification placeholder
void main() => runApp(const EnglishSikhoApp());

class EnglishSikhoApp extends StatelessWidget {
  const EnglishSikhoApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'English Sikho',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5426A8)),
        ),
        home: const LearningHome(),
      );
}
