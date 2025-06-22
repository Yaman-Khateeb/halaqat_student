import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:himmah_tracker/modules/attendance.dart';
import 'package:himmah_tracker/providers/app_providers.dart';
import 'package:himmah_tracker/services/attendance_api.dart';
import 'package:himmah_tracker/widgets/attendance/attendance_record.dart';

import 'package:himmah_tracker/widgets/month_selector.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AttendanceScreen extends ConsumerStatefulWidget {
  const AttendanceScreen({super.key});

  @override
  ConsumerState<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends ConsumerState<AttendanceScreen> {
  DateTime date = DateTime.now();
   List<Attendance> attendanceForMonth = [];
  List<Attendance> attendanceList = [];
  late int groupID, campaignID, studentID;

  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _fetchAttendance();
    
  }
  Future<void> _fetchAttendance ()async
  {
    await fetchAttendance();
    attendanceForMonth =
        attendanceList.where((a) => a.date.month == date.month).toList();

        setState(() {
          isLoading = false;
        });
  }

  //calciulate the attendance Percentage
  // int get attendanceCount => attendanceForMonth.where((a)=> a.didAttended).length;

  // double get attendancePercent => attendanceCount / attendanceForMonth.length;

int get attendanceCount 
{
    if(isLoading) return 0;
  return attendanceForMonth.where((a) => a.didAttended).length;
}

  double get attendancePercent {
    if(isLoading) return 0;
    if (attendanceForMonth.isEmpty) return 0;
    return attendanceCount / attendanceForMonth.length;
  }
  

  @override
  Widget build(BuildContext context) {
    // groupID = ref.watch(groupIDProvider)!;
    // campaignID = ref.watch(campaignIDProvider)!;
    // studentID = ref.watch(currentUserProvider)!.id;
    // print('Entering attendance API📊');
    // final api = AttendanceApi(groupID, campaignID, studentID);
    // api.getAttendanceForStudent();
    
    if(isLoading)
    {
      return const Scaffold(
        body:  Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              MonthSelector(
                initialDate: date,
                canNavigateToMonth: (newDate) async {
                  print('Trying to navigate to: $newDate');

                  for (var a in attendanceList!) {
                    print(
                      'Checking ${a.date}: ${a.date.month == newDate.month && a.date.year == newDate.year}',
                    );
                  }

                  final result = attendanceList!.any(
                    (a) =>
                        a.date.month == newDate.month &&
                        a.date.year == newDate.year,
                  );

                  print('Result: $result');
                  return result;
                },

                onMonthChanged: (newDate) {
                  setState(() {
                    date = newDate;
                    attendanceForMonth =
                        attendanceList!
                            .where(
                              (a) =>
                                  a.date.month == newDate.month &&
                                  a.date.year == newDate.year,
                            )
                            .toList();
                  });
                  // setState(() {
                  //   date = newDate;
                  //   attendanceForMonth =
                  //       attendanceData
                  //           .where(
                  //             (a) =>
                  //                 a.date.month == date.month &&
                  //                 a.date.year == date.year,
                  //           )
                  //           .toList();
                  // });
                },
              ),
              const SizedBox(height: 20),
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
                      fontSize: 38,
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
                },
              ),
              const SizedBox(height: 26),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchAttendance() async {
    final _groupID = ref.read(groupIDProvider)!;
    final _campaignID = ref.read(campaignIDProvider)!;
    final _studentID = ref.read(currentUserProvider)!.id;

    final api = AttendanceApi(_groupID, _campaignID, _studentID);
     attendanceList = await api.getAttendanceForStudent();

    if (attendanceList != []) {
      setState(() {
        attendanceForMonth =
            attendanceList
                .where(
                  (a) => a.date.month == date.month && a.date.year == date.year,
                )
                .toList();
      });
    }
  }
}
