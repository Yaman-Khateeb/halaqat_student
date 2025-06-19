import 'package:flutter/material.dart';
import 'package:himmah_tracker/screens/attendance_screen.dart';
import 'package:himmah_tracker/widgets/attendance/attendance_record.dart';
import 'package:himmah_tracker/widgets/custom_app_bar.dart';
import 'package:himmah_tracker/widgets/custom_bottom_navbar.dart';
import 'package:himmah_tracker/widgets/custome_drawer.dart';
import 'package:qr_flutter/qr_flutter.dart';
class QrCodePage extends StatelessWidget {
  const QrCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5F3F5),
appBar: const CustomAppBar(),
drawer: const CustomDrawer(),
body: Center(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      QrImageView(
        data: 'L200k',
        version: QrVersions.auto,
        size: 280,
        dataModuleStyle: QrDataModuleStyle(
          dataModuleShape: QrDataModuleShape.square,
          color: Theme.of(context).colorScheme.primary,
          
        ),
          eyeStyle: QrEyeStyle(
    eyeShape: QrEyeShape.square,
    color: Theme.of(context).colorScheme.primary.withValues(alpha:0.90),
  ),
      ),
      const SizedBox(height: 24),
      Text(
        'L200k',
        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary.withValues(alpha:0.85),
              fontWeight: FontWeight.bold,              
            ),
            
      ),
      const SizedBox(height: 32),Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Theme.of(context).colorScheme.primary,
        Theme.of(context).colorScheme.primary.withValues(alpha:  0.85),
        Theme.of(context).colorScheme.primary.withValues(alpha:  0.75),
      ],
    ),
    borderRadius: BorderRadius.circular(12),
  ),
  child: ElevatedButton.icon(
    onPressed: () {
      // Navigate to attendance screen
      Navigator.of(context).push(
        DialogRoute(
          context: context,
          builder: (context) => const AttendanceScreen(),
        ),
      );
    },
    icon: const Icon(Icons.bar_chart_rounded),
    label: const Text('عرض سجل الحضور'),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      foregroundColor: Colors.white,
      textStyle: Theme.of(context).textTheme.titleMedium,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
),

    ],
  ),
)
,
    bottomNavigationBar: const CustomBottomNavbar(currentIndex: 2),
    );
  }
}