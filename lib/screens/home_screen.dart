import 'package:flutter/material.dart';
import 'reminder_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <_Feature>[
      _Feature('Daily Lesson', Icons.menu_book_rounded, 'Learn one topic every day'),
      _Feature('Practice', Icons.record_voice_over_rounded, 'Speak, translate and revise'),
      _Feature('Verb Bank', Icons.library_books_rounded, 'Useful English verbs'),
      _Feature('Progress', Icons.track_changes_rounded, 'Track your learning goals'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('English Sikho', style: TextStyle(fontWeight: FontWeight.w800)),
        actions: [
          IconButton(
            tooltip: 'Practice reminder',
            icon: const Icon(Icons.notifications_active_outlined),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ReminderScreen()),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF5426A8), Color(0xFF8055D6)]),
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your English journey starts here',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Small daily practice. Real-life confidence.',
                  style: TextStyle(color: Colors.white70),
                ),
                SizedBox(height: 18),
                Text(
                  'Overall syllabus progress: 0%',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 8),
                LinearProgressIndicator(
                  value: 0,
                  minHeight: 8,
                  backgroundColor: Colors.white30,
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const Text('Continue learning', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ...items.map((item) => Card(
                elevation: 0,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFFEDE5FF),
                    child: Icon(item.icon, color: const Color(0xFF5426A8)),
                  ),
                  title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(item.subtitle),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    if (item.title == 'Practice') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ReminderScreen()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${item.title} module is in the next build milestone.')),
                      );
                    }
                  },
                ),
              )),
          const SizedBox(height: 12),
          const Text(
            'No Shame Mode is on: mistakes are part of learning.',
            style: TextStyle(color: Color(0xFF625B71)),
          ),
        ],
      ),
    );
  }
}

class _Feature {
  final String title;
  final IconData icon;
  final String subtitle;
  const _Feature(this.title, this.icon, this.subtitle);
}
