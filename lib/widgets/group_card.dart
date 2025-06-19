import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroupCard extends StatelessWidget {
  final Map<String, dynamic> group;

  const GroupCard(this.group, {Key? key}) : super(key: key);

  Future<void> _onTap(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('group_id', group['id'] as int);
    // Navigate to home screen
    Navigator.pushNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () => _onTap(context),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                group['title'] ?? 'بدون عنوان',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              Text('الصف: ${group['class'] ?? 'غير محدد'}'),
            ],
          ),
        ),
      ),
    );
  }
}
