import 'package:himmah_tracker/modules/attendance.dart';
import 'package:himmah_tracker/modules/campaign.dart';
import 'package:himmah_tracker/modules/quran_challenge.dart';
import 'package:himmah_tracker/modules/reciteSession.dart';
import 'package:himmah_tracker/modules/tasks.dart';
import 'package:himmah_tracker/modules/user.dart';





// final attendanceData = [
//   Attendance(date: DateTime( 2025,  4,  1), didAttended: false),
//   Attendance(date: DateTime( 2025,  4,  4), didAttended: true),
//   Attendance(date: DateTime( 2025,  4,  7), didAttended: true),
//   Attendance(date: DateTime( 2025,  4,  10), didAttended: false),
//   Attendance(date: DateTime( 2025,  5,  13), didAttended: true),
//   Attendance(date: DateTime( 2025,  5,  18), didAttended: false),
//   Attendance(date: DateTime( 2025,  5,  22), didAttended: true),
//   Attendance(date: DateTime( 2025,  5,  1), didAttended: true),
//   Attendance(date: DateTime( 2025,  6,  1), didAttended: false),
//   Attendance(date: DateTime( 2025,  6,  1), didAttended: true),
//   Attendance(date: DateTime( 2025,  6,  1), didAttended: true),
//   Attendance(date: DateTime( 2025,  6,  1), didAttended: true),
// ];

// final reciteSessions = [  
//   ReciteSession(pagesAmount: 5, grade: 23, date: DateTime(2025, 4, 1), description: 'يوجد بعض الأخطاء الصفحات بحاجة لإعادة'),
//   ReciteSession(pagesAmount: 1, grade: 99, date: DateTime(2025, 4, 3),),
//   ReciteSession(pagesAmount: 2, grade: 88, date: DateTime(2025, 4, 5),),
//   ReciteSession(pagesAmount: 1, grade: 69, date: DateTime(2025, 4, 7),),
//   ReciteSession(pagesAmount: 5, grade: 88, date: DateTime(2025, 4, 9),),
//   ReciteSession(pagesAmount: 2, grade: 89, date: DateTime(2025, 4, 11),),
//   ReciteSession(pagesAmount: 1, grade: 89, date: DateTime(2025, 4, 15),),
//   ReciteSession(pagesAmount: 2, grade: 89, date: DateTime(2025, 4, 18),),
  
//   ReciteSession(pagesAmount: 3, grade: 83, date: DateTime(2025, 5, 2),),
//   ReciteSession(pagesAmount: 1, grade: 85, date: DateTime(2025, 5, 5),),
//   ReciteSession(pagesAmount: 1, grade: 55, date: DateTime(2025, 5, 8),),
//   ReciteSession(pagesAmount: 8, grade: 75, date: DateTime(2025, 5, 23),),

//   ReciteSession(pagesAmount: 1, grade: 55, date: DateTime(2025, 7, 8),),

//   ReciteSession(pagesAmount: 3, grade: 83, date: DateTime(2025, 3, 3),),
//   ReciteSession(pagesAmount: 12, grade: 87, date: DateTime(2025, 3, 9),),
//   ReciteSession(pagesAmount: 2, grade: 83, date: DateTime(2025, 3, 15),),
//   ReciteSession(pagesAmount: 1, grade: 55, date: DateTime(2025, 3, 17),),
//   ReciteSession(pagesAmount: 15, grade: 85, date: DateTime(2025, 3, 23),),
  
//   ReciteSession(pagesAmount: 3, grade: 83, date: DateTime(2025, 1, 3),),
// ];



final quranChallenges = [
  QuranChallenge(
    startDate: DateTime(2025, 5, 5),
    requiredAmount: 25
 ),
 QuranChallenge(
    startDate: DateTime(2025, 7, 1),
    requiredAmount: 25
 ),
 
 ];


final dailyTaks = [
const Tasks(title: 'أذكار الصباح', type: enTaskType.azkar),
const Tasks(title: 'أذكار المساء', type: enTaskType.azkar),
const Tasks(title: 'استغفار',amount: 100, amountTypeDescription: 'مرة', type: enTaskType.azkar),
const Tasks(title: 'صلاة الجماعة في المسجد',amount: 2, amountTypeDescription: 'صلاة', type: enTaskType.prayer),
const Tasks(title: 'دراسة درس واحد', type: enTaskType.azkar),
];



final campaigns = [
    Campaign(id: 1, name: 'دورة صيفية', startDate: DateTime(2025, 6, 1), days: ['سبت ','إثنين', 'أربعاء'], startTime: '14:30', endTime:'17:30' )
];