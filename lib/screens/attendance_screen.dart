import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:himmah_tracker/dummy_data/dummy_data.dart';
import 'package:himmah_tracker/modules/attendance.dart';
import 'package:himmah_tracker/widgets/attendance/attendance_record.dart';

import 'package:himmah_tracker/widgets/month_selector.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
class AttendanceScreen extends StatefulWidget {
   const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
            DateTime date = DateTime.now();
  late List<Attendance> attendanceForMonth;
  @override
  void initState()
  {
    super.initState();
    attendanceForMonth = attendanceData.where((a) => a.date.month == date.month).toList();
  }
   
              //calciulate the attendance Percentage
                int get attendanceCount => attendanceForMonth.where((a)=> a.didAttended).length;

                double get attendancePercent => attendanceCount / attendanceForMonth.length;
  @override
  Widget build(BuildContext context) {
    
            
       return Scaffold(
      appBar: AppBar(                
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            
            children: [
              
              MonthSelector(
              initialDate: date,
              canNavigateToMonth: (newDate) async {
  print('Trying to navigate to: $newDate');

  for (var a in attendanceData) {
    print('Checking ${a.date}: ${a.date.month == newDate.month && a.date.year == newDate.year}');
  }

  final result = attendanceData.any((a) =>
      a.date.month == newDate.month && a.date.year == newDate.year);

  print('Result: $result');
  return result;
},

            onMonthChanged: (newDate) {
    setState(() {
      date = newDate;
      attendanceForMonth = attendanceData
          .where((a) => a.date.month == date.month && a.date.year == date.year)
          .toList();
    });
  },
),
              const SizedBox(height: 20,),
              Text(
                'نسبة الحضور للشهر الحالي',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      fontFamily: GoogleFonts.tajawal().fontFamily,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: CircularPercentIndicator(
                    radius: 120.0,
                    lineWidth: 22.0,
                    percent: attendancePercent,
                    animation: true,
                    animationDuration: 1200,
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: Colors.teal,
                    backgroundColor: const Color.fromARGB(255, 216, 218, 218),
                    center: Text(
                      "${attendancePercent * 100}%",
                      style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.tajawal().fontFamily,
                            fontSize: 38
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                
                
              
              
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                 itemCount: attendanceForMonth.length,
                itemBuilder: (context, index) {
                  return AttendanceRecore(attendanceForMonth[index]);
                } 
                 ),
                 const SizedBox(height: 26),
          
            ],
              ),
        ),
      ),
      
       );
  }
}