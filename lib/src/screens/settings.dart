import 'package:wordle_game/src/utils/quick_box.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Settings'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => Navigator.maybePop(context),
            icon: const Icon(Icons.clear),
          ),
        ],
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Statistiken zurücksetzen'),
            onTap: () => _resetStatistics(() {
              if (mounted) {
                runQuickBox(context: context, message: 'Statistiken zurückgesetzt');
              }
            }),
          ),
        ],
      ),
    );
  }

  Future<void> _resetStatistics(VoidCallback onSuccess) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('stats');
    prefs.remove('chart');
    prefs.remove('row');
    onSuccess();
  }
}
