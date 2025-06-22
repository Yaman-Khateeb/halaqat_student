import 'package:flutter/material.dart';

import 'package:himmah_tracker/modules/reciteSession.dart';
import 'package:himmah_tracker/services/recites_api.dart';
import 'package:himmah_tracker/widgets/custom_app_bar.dart';
import 'package:himmah_tracker/widgets/custom_bottom_navbar.dart';
import 'package:himmah_tracker/widgets/custome_drawer.dart';
import 'package:himmah_tracker/widgets/month_selector.dart';
import 'package:himmah_tracker/widgets/quran/column_chart.dart';

import 'package:himmah_tracker/widgets/quran/quran_challenge_chart.dart';
import 'package:himmah_tracker/widgets/quran/recite_session.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    DateTime date = DateTime.now();
    
    List<ReciteSession> reciteSessions = [];
    late final int campaignID, groupID;
    
    bool isLoading = true;

   @override
void initState() {
  super.initState();
  _initData(); // Call the async method
}

Future<void> _initData() async {
  final pref = await SharedPreferences.getInstance();
  campaignID = pref.getInt('campaign_id') ?? -1;
  groupID = pref.getInt('group_id') ?? -1;

  final sessionsMap = await ReciteSessionApi(campaignId: campaignID, studentId: groupID).getReciteSessions();
  
  if (sessionsMap != null) {
   print( 'home:/ successfully got session: start page: ${ReciteSession.fromJson(sessionsMap[0]).start}');
    setState(() {
      reciteSessions = sessionsMap.map((reciteMap) => ReciteSession.fromJson(reciteMap)).toList();
    });
  } else {
    setState(() {
      reciteSessions = [];
    });

    
  print('Recite sessions: $reciteSessions');
  for(final recite in reciteSessions!)
  {
    print(' a recite:');
    print('${recite.date} ${recite.pagesAmount}');
  }
  }


  setState(() {
      isLoading = false;
    }    
    );

}

  final PageController _controller = PageController();
  
//   final noRecitesContent =  Center(
  
//   child: Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       (DateTime.now().month != date.month)? 
//        Text(
//          'للأسف، لا توجد جلسات تسميع لهذا الشهر.',
//         style: TextStyle(
//           fontSize: 16,
//           fontWeight: FontWeight.w500,
//           color: Colors.grey,
//         ),
//         textAlign: TextAlign.center,
//       ) : const Text('لم تقم بأي جلسة تسميع هذا الشهر.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey), textAlign: TextAlign.center,),
//       const SizedBox(height: 10),
//       Image.asset('assets/images/boy_book.png', height: 180), // Adjust size as needed
//     ],
//   )
// );




@override
Widget build(BuildContext context) {

  if(isLoading)
  {
  return const Scaffold(
    body: Center(child: CircularProgressIndicator(),),
  );
  }


  final bool isCurrentMonth = DateTime.now().month == date.month &&
                              DateTime.now().year == date.year;

  final Widget noRecitesContent = Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isCurrentMonth
              ? 'لم تقم بأي جلسة تسميع هذا الشهر.\nابدأ اليوم أول جلسة وحقق هدفك! 🌱'
              : 'للأسف، لا توجد جلسات تسميع لهذا الشهر.',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Image.asset(
          'assets/images/boy_book.png',
          height: 180,
        ),
      ],
    ),
  );

  return Scaffold(
    appBar: const CustomAppBar(),
    drawer: const CustomDrawer(),
    body: SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            MonthSelector(
              initialDate: date,
              canNavigateToMonth: (newDate) async {
                if (reciteSessions.isEmpty) {
                  return false;
                }
                final sessions = [...reciteSessions];
                sessions.sort((ses1, ses2) => ses1.date.compareTo(ses2.date));
                return isNewDateBetween(
                    newDate, sessions.first.date, sessions.last.date);
              },
              onMonthChanged: (newDate) {
                setState(() {
                  date = DateTime(newDate.year, newDate.month);
                  reciteSessions = reciteSessions!
                      .where((session) =>
                          session.date.year == date.year &&
                          session.date.month == date.month)
                      .toList();
                });
              },
            ),
            Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: [
                    
                    SizedBox(
                      height: 350,
                      child: PageView.builder(
                        itemCount: 2,
                        controller: _controller,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return QuranWeeklyChart(
                              reciteSessions: reciteSessions,
                                year: date.year, month: date.month);
                          }
                          if (index == 1) {
                            return QuranChallengeChart(
                              reciteSessions: reciteSessions,
                              year: date.year,
                              month: date.month,
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
                    SmoothPageIndicator(
                      controller: _controller,
                      count: 2,
                      effect: const WormEffect(
                          dotHeight: 6,
                          dotWidth: 6,
                          activeDotColor: Colors.green,
                          dotColor: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            (reciteSessions!.isEmpty)
                ? noRecitesContent
                : Text(
                    ':جلسات تسميع القرآن الكريم للشهر الحالي',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: reciteSessions.length,
              itemBuilder: (context, index) 
              {
                 print('recite session ${index} ${reciteSessions[index].pagesAmount}');
                  return ReciteSessionWidget(reciteSessions[index]);
              }
            ),
          ],
        ),
      ),
    ),
    bottomNavigationBar: const CustomBottomNavbar(currentIndex: 3),
  );
}

}
bool isNewDateBetween(DateTime newDate, DateTime start, DateTime end) {
  final newMonth = DateTime(newDate.year, newDate.month);
  final startMonth = DateTime(start.year, start.month);
  final endMonth = DateTime(end.year, end.month);
  return !newMonth.isBefore(startMonth) && !newMonth.isAfter(endMonth);
}
