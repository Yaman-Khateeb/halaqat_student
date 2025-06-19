import 'package:flutter/material.dart';
import 'package:himmah_tracker/dummy_data/dummy_data.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
class CampaignsScreen extends StatelessWidget {
  const CampaignsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulated campaign data
    

    // final startDateFormatted = DateFormat.yMMMMd('ar').format(campaigns[0].startDate);
    final startDateFormatted = DateFormat.yMMMMd().format(campaigns[0].startDate);
    // final daysArabic = {
    //   "saturday": "السبت",
    //   "sunday": "الأحد",
    //   "monday": "الإثنين",
    //   "tuesday": "الثلاثاء",
    //   "wednesday": "الأربعاء",
    //   "thursday": "الخميس",
    //   "friday": "الجمعة",
    // };
    final readableDays = (campaigns[0].days);
        

    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('اختر دورة'),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: ExpansionTile(
                iconColor: Colors.red,
                tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                title: Text(
                  campaigns[0].name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                
                childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                children: [
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 20),
                      const SizedBox(width: 8),
                      Text('تاريخ البداية: $startDateFormatted'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 20),
                      const SizedBox(width: 8),
                      Text('من ${campaigns[0].startTime} إلى ${campaigns[0].endTime}'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.event_repeat, size: 20),
                      const SizedBox(width: 8),
                      Text('أيام الدورة: $readableDays'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
