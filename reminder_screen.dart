import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  TimeOfDay selectedTime = const TimeOfDay(hour: 20, minute: 30);
  bool enabled = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final hour = prefs.getInt('reminder_hour') ?? 20;
    final minute = prefs.getInt('reminder_minute') ?? 30;
    final isEnabled = prefs.getBool('reminder_enabled') ?? false;
    if (!mounted) return;
    setState(() {
      selectedTime = TimeOfDay(hour: hour, minute: minute);
      enabled = isEnabled;
    });
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('reminder_hour', selectedTime.hour);
    await prefs.setInt('reminder_minute', selectedTime.minute);
    await prefs.setBool('reminder_enabled', enabled);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Preference saved. Notification scheduling will be connected in the next milestone.')),
    );
  }

  Future<void> _chooseTime() async {
    final result = await showTimePicker(context: context, initialTime: selectedTime);
    if (result != null) setState(() => selectedTime = result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Practice Reminder')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Build a daily habit', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Choose when English Sikho should remind you to practise tomorrow and on following days.'),
          const SizedBox(height: 28),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Enable daily reminder'),
            value: enabled,
            onChanged: (v) => setState(() => enabled = v),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              title: const Text('Practice time'),
              subtitle: Text(selectedTime.format(context), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              trailing: const Icon(Icons.access_time),
              onTap: _chooseTime,
            ),
          ),
          const SizedBox(height: 18),
          const Text('Reminder sound will use the Android notification sound. You can change it in Android notification settings.'),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: FilledButton(onPressed: _save, child: const Text('Save reminder preference')),
          ),
        ]),
      ),
    );
  }
}
