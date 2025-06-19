import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:himmah_tracker/dummy_data/dummy_data.dart';


class QuranChallengeChart extends StatelessWidget {
  const QuranChallengeChart({
    super.key,
    required this.year,
    required this.month,
  });                                   

  final int year;
  final int month;

  @override
  Widget build(BuildContext context) {
    final challengesForMonth = quranChallenges
        .where((challenge) =>
            challenge.startDate.year <= year &&
            challenge.startDate.month <= month)
        .toList();

    if (challengesForMonth.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Icon(Icons.info_outline, size: 60, color: Colors.grey),
            const SizedBox(height: 12),
            Text(
              'لا يوجد تحدي قرآن لهذا الشهر',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
                fontFamily: GoogleFonts.tajawal().fontFamily,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    // Get the latest challenge for the month
    challengesForMonth.sort((a, b) => a.startDate.compareTo(b.startDate));
    final challenge = challengesForMonth.last;

    // Filter recited sessions only within the challenge date range
    final recitedAmount = reciteSessions.where(
      (session) =>
          session.date.year == year && 
          session.date.month == month 
          
    ).length;

    final recitedPercentage =
        (recitedAmount / challenge.requiredAmount).clamp(0.0, 1.0);
    final roundedPercentage =
        double.parse(recitedPercentage.toStringAsFixed(2));

    return Column(
      children: [
        CircularPercentIndicator(
          radius: 120.0,
          lineWidth: 22.0,
          percent: roundedPercentage,
          animation: true,
          animationDuration: 1300,
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: Colors.teal,
          backgroundColor: const Color.fromARGB(255, 216, 218, 218),
          center: Text(
            "${(roundedPercentage * 100).toStringAsFixed(0)}%",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.tajawal().fontFamily,
              fontSize: 38,
            ),
          ),
        ),
        const SizedBox(height: 40),
        const Text(
          'تحدي القرآن الشهري',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'تم إنجاز $recitedAmount من أصل ${challenge.requiredAmount} صفحة',
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: const Color.fromARGB(255, 116, 116, 116)),
        ),
      ],
    );
  }
}
