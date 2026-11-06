import 'package:flutter/material.dart';

void main() {
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
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('English Sikho 📚'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Learning Progress',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const LinearProgressIndicator(value: 0),
                  const SizedBox(height: 8),
                  const Text('0% completed'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          featureCard(
            context,
            'Daily English Lesson',
            'Learn English every day',
            Icons.menu_book,
          ),
          featureCard(
            context,
            'Speaking Practice',
            'Improve your speaking skills',
            Icons.mic,
          ),
          featureCard(
            context,
            'Practice & Quiz',
            'Test your English knowledge',
            Icons.quiz,
          ),
          featureCard(
            context,
            'Verb Bank',
            '3000+ English verbs with Hindi meanings',
            Icons.library_books,
          ),
          featureCard(
            context,
            'Daily Reminder',
            'Set your daily practice time',
            Icons.notifications,
          ),
        ],
      ),
    );
  }

  Widget featureCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
  ) {
    return Card(
      child: ListTile(
        leading: Icon(icon, size: 30),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$title coming soon')),
          );
        },
      ),
    );
  }
}
