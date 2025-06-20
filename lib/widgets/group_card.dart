import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:himmah_tracker/providers/app_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroupCard extends ConsumerWidget {
  final Map<String, dynamic> group;

  const GroupCard(this.group, {Key? key}) : super(key: key);

  Future<void> _onTap(BuildContext context,WidgetRef ref) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('group_id', group['id'] as int);
    ref.watch(groupIDProvider.notifier).state = group['id'];
    // Navigate to home screen
    Navigator.pushNamed(context, '/home');

  }

  @override
  Widget build(BuildContext context,ref) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () => _onTap(context,ref),
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
