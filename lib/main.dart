import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const EnglishSikhoApp());

class EnglishSikhoApp extends StatelessWidget {
  const EnglishSikhoApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'English Sikho',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: const Color(0xFF5426A8)),
        home: const LearningHome(),
      );
}

class LearningHome extends StatefulWidget {
  const LearningHome({super.key});
  @override
  State<LearningHome> createState() => _LearningHomeState();
}

class _LearningHomeState extends State<LearningHome> {
  int _tab = 0;
  bool _loading = true;
  List<Map<String, dynamic>> _days = [];
  List<Map<String, dynamic>> _verbs = [];
  Set<int> _completed = {};

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final course = jsonDecode(await rootBundle.loadString('assets/data/course_100_days.json')) as List<dynamic>;
      final verbs = jsonDecode(await rootBundle.loadString('assets/data/verbs_sample.json')) as List<dynamic>;
      final prefs = await SharedPreferences.getInstance();
      if (!mounted) return;
      setState(() {
        _days = course.cast<Map<String, dynamic>>();
        _verbs = verbs.cast<Map<String, dynamic>>();
        _completed = (prefs.getStringList('completed_days') ?? []).map(int.parse).toSet();
        _loading = false;
      });
    } catch (error) {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _complete(int day) async {
    final prefs = await SharedPreferences.getInstance();
    _completed.add(day);
    await prefs.setStringList('completed_days', _completed.map((e) => '$e').toList());
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    if (_days.isEmpty) return const Scaffold(body: Center(child: Text('Course data could not be loaded.')));
    final titles = ['Home', '100-Day Course', 'Verb Bank', 'Progress'];
    final views = [
      _home(),
      _course(),
      _verbBank(),
      _progress(),
    ];
    return Scaffold(
      appBar: AppBar(title: Text('English Sikho • ${titles[_tab]}')),
      body: views[_tab],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (index) => setState(() => _tab = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.menu_book_outlined), label: 'Course'),
          NavigationDestination(icon: Icon(Icons.translate), label: 'Verbs'),
          NavigationDestination(icon: Icon(Icons.insights), label: 'Progress'),
        ],
      ),
    );
  }

  Widget _home() {
    final percent = _completed.length / 100;
    final next = _days.firstWhere((day) => !_completed.contains(day['day']), orElse: () => _days.last);
    return ListView(padding: const EdgeInsets.all(16), children: [
      Card(color: Theme.of(context).colorScheme.primary, child: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('रोज़ थोड़ा सीखें, आत्मविश्वास से बोलें!', style: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8), const Text('Learn English step by step, with Hindi support.', style: TextStyle(color: Colors.white)),
        const SizedBox(height: 16), LinearProgressIndicator(value: percent, backgroundColor: Colors.white30, color: Colors.white),
        const SizedBox(height: 8), Text('${_completed.length}/100 days complete', style: const TextStyle(color: Colors.white)),
      ]))),
      Card(child: ListTile(leading: const Icon(Icons.play_circle), title: Text('Continue: Day ${next['day']}'), subtitle: Text(next['topic'] as String), onTap: () => _openLesson(next))),
      Card(child: ListTile(leading: const Icon(Icons.menu_book), title: const Text('100-day learning course'), subtitle: const Text('Beginner-friendly lessons with Hindi support'), onTap: () => setState(() => _tab = 1))),
      const Card(child: ListTile(leading: Icon(Icons.wifi_off), title: Text('Works offline'), subtitle: Text('Course and sample verbs are included in the app.'))),
    ]);
  }

  Widget _course() => ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _days.length,
        itemBuilder: (context, index) {
          final day = _days[index];
          final number = day['day'] as int;
          return Card(child: ListTile(
            leading: CircleAvatar(child: _completed.contains(number) ? const Icon(Icons.check) : Text('$number')),
            title: Text(day['topic'] as String),
            subtitle: Text('Day $number • ${day['stage']}'),
            onTap: () => _openLesson(day),
          ));
        },
      );

  Widget _verbBank() => ListView(padding: const EdgeInsets.all(12), children: [
        const Padding(padding: EdgeInsets.all(8), child: Text('Starter verb list (sample)', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        for (final verb in _verbs) Card(child: ListTile(
          title: Text('${verb['v1']} — ${verb['hindi']}'),
          subtitle: Text('Past: ${verb['v2']} • Participle: ${verb['v3']}\n${verb['example']}'),
        )),
      ]);

  Widget _progress() => ListView(padding: const EdgeInsets.all(16), children: [
        const Text('Your progress', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        LinearProgressIndicator(value: _completed.length / 100, minHeight: 10),
        const SizedBox(height: 8),
        Text('${_completed.length} of 100 lessons completed'),
      ]);

  void _openLesson(Map<String, dynamic> day) {
    final number = day['day'] as int;
    showModalBottomSheet<void>(context: context, isScrollControlled: true, builder: (context) => SafeArea(child: Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(shrinkWrap: true, children: [
        Text('Day $number: ${day['topic']}', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 12),
        const Text('Grammar / व्याकरण', style: TextStyle(fontWeight: FontWeight.bold)),
        const Text('A basic English sentence often follows Subject + Verb + Object. Start with a short sentence and say it aloud.'),
        const SizedBox(height: 12),
        const Text('Example: I learn English every day. — मैं हर दिन अंग्रेज़ी सीखता/सीखती हूँ।'),
        const SizedBox(height: 12),
        const Text('Speaking practice: Say the example aloud three times, then make one sentence about yourself.'),
        const SizedBox(height: 16),
        FilledButton(onPressed: () async { await _complete(number); if (context.mounted) Navigator.pop(context); }, child: const Text('Mark lesson complete')),
      ]),
    )));
  }
}
