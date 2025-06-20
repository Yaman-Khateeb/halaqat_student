import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:himmah_tracker/providers/app_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Import your SelectGroupScreen route or define a constant route name
// import 'package:himmah_tracker/screens/select_group_screen.dart';

class CampaignCard extends ConsumerWidget {
  const CampaignCard(this.campaign, {super.key});
  final Map<String, dynamic> campaign;

  @override
  Widget build(BuildContext context,ref) {
    final bool isActive = campaign["status"] == true;
    final Color cardColor = isActive
        ? const Color.fromARGB(255, 211, 243, 244)
        : const Color.fromARGB(226, 226, 229, 236);
    final Color statusColor = isActive ? Colors.lightBlue : Colors.grey;

    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            campaign["name"] ?? 'بدون اسم',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(height: 16),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'الأيام: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '${campaign["days"] ?? ''}',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'الوقت: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        '${campaign['startTime'] ?? ''} - ${campaign['endTime'] ?? ''}',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                isActive ? "الدورة قائمة" : "منتهية",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        onTap: () async {
          final prefs = await SharedPreferences.getInstance();

          // Store campaign ID
          await prefs.setInt('campaign_id', campaign['id'] as int);
          ref.read(campaignIDProvider.notifier).state = campaign['id'];
          print('saved the campaign id to provider: 🔥 ${campaign['id']}');
          debugPrint('Saved campaign_id: ${prefs.getInt('campaign_id')}');

          // Navigate to SelectGroupScreen with pushReplacementNamed
          // Assuming you have set up routes like '/select-groups'
          // Pass studentId and campaignId via arguments or via a route generator

          final int studentId = prefs.getInt('student_id') ?? 1; // or get from elsewhere
          final int campaignId = campaign['id'] as int;

          Navigator.pushReplacementNamed(
            context,
            '/select-groups',            
          );
        },
      ),
    );
  }
}
