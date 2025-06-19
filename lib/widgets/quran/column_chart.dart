import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:himmah_tracker/dummy_data/dummy_data.dart'; // contains reciteSessions

class QuranWeeklyChart extends StatelessWidget {
  const QuranWeeklyChart({super.key, required this.year, required this.month});

  final int year;
  final int month;

  /// Generates data for the weekly chart. Groups recitations by week number.
  /// Returns a list of 4 elements, each containing the week number and the number
  /// of pages recited in that week.
  List<_WeeklyData> _generateWeeklyData() {
    final sessionsForMonth = reciteSessions.where((session) =>
        session.date.year == year && session.date.month == month).toList();

    // Group recitations by week number
    final List<int> weeklyCounts = [0, 0, 0, 0];

    for (final session in sessionsForMonth) {
      final int weekIndex = ((session.date.day - 1) ~/ 7).clamp(0, 3);
      weeklyCounts[weekIndex]+= session.pagesAmount;
    }

      const List<String> weekName = [
        'الأول' ,
        'الثاني',
        'الثالث',
        'الرابع',
      ];

    return List.generate(4, (i) => _WeeklyData('الأسبوع ${weekName[3 - i]}', weeklyCounts[3 - i]));
  }

  @override
  Widget build(BuildContext context) {
    final weeklyData = _generateWeeklyData();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SfCartesianChart(
        title: const ChartTitle(text: 'مقارنة الأسابيع الأربعة'),
        primaryXAxis: const  CategoryAxis(
          labelStyle: TextStyle(fontFamily: 'Tajawal', fontSize: 10),
        ),
        primaryYAxis: const NumericAxis(
          title: AxisTitle(text: 'عدد الصفحات', textStyle: TextStyle(fontFamily: 'Tajawal', fontSize: 12)),
          opposedPosition: true,
          minimum: 0,
          interval: 1,
        ),
        tooltipBehavior: TooltipBehavior(enable: true),
       series: <CartesianSeries<_WeeklyData, String>>[
        ColumnSeries<_WeeklyData, String>(
      dataSource: weeklyData,
      xValueMapper: (_WeeklyData data, _) => data.weekLabel,
      yValueMapper: (_WeeklyData data, _) => data.pagesCount,
      dataLabelSettings: const DataLabelSettings(isVisible: true),
      color: Colors.teal,
      name: 'جلسات',
        )
      ],
      
      ),
    );
  }
}

class _WeeklyData {
  final String weekLabel;
  final int pagesCount;

  _WeeklyData(this.weekLabel, this.pagesCount);
}



// /// Package import.
// import 'package:flutter/material.dart';

// /// Chart import.
// import 'package:syncfusion_flutter_charts/charts.dart';

// /// Local import.


// /// Renders default Column Chart sample.
// class ColumnDefault extends SampleView {
//   const ColumnDefault(Key key) : super(key: key);

//   @override
//   _ColumnDefaultState createState() => _ColumnDefaultState();
// }

// class _ColumnDefaultState extends SampleViewState {
//   _ColumnDefaultState();

//   TooltipBehavior? _tooltipBehavior;
//   List<ChartSampleData>? _chartData;

//   @override
//   void initState() {
//     _tooltipBehavior = TooltipBehavior(
//       enable: true,
//       header: '',
//       canShowMarker: false,
//     );
//     _chartData = <ChartSampleData>[
//       ChartSampleData(x: 'China', y: 0.541),
//       ChartSampleData(x: 'Brazil', y: 0.818),
//       ChartSampleData(x: 'Bolivia', y: 1.51),
//       ChartSampleData(x: 'Mexico', y: 1.302),
//       ChartSampleData(x: 'Egypt', y: 2.017),
//       ChartSampleData(x: 'Mongolia', y: 1.683),
//     ];
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _buildCartesianChart();
//   }

//   /// Return the Cartesian Chart with Column series.
//   SfCartesianChart _buildCartesianChart() {
//     return SfCartesianChart(
//       plotAreaBorderWidth: 0,
//       title: ChartTitle(
//         text: isCardView ? '' : 'Population growth of various countries',
//       ),
//       primaryXAxis: const CategoryAxis(
//         majorGridLines: MajorGridLines(width: 0),
//       ),
//       primaryYAxis: const NumericAxis(
//         axisLine: AxisLine(width: 0),
//         labelFormat: '{value}%',
//         majorTickLines: MajorTickLines(size: 0),
//       ),
//       series: _buildColumnSeries(),
//       tooltipBehavior: _tooltipBehavior,
//     );
//   }

//   /// Returns the list of Cartesian Column series.
//   List<ColumnSeries<int, String>> _buildColumnSeries() {
//     return <ColumnSeries<int, String>>[
//       ColumnSeries<int, String>(
//         dataSource: _chartData,
//         xValueMapper: (int sales, int index) => sales.x,
//         yValueMapper: (int sales, int index) => sales.y,
//         dataLabelSettings: const DataLabelSettings(
//           isVisible: true,
//           textStyle: TextStyle(fontSize: 10),
//         ),
//       ),
//     ];
//   }

//   @override
//   @override
//   void dispose() {
//     if (_chartData != null) {
//       _chartData!.clear();
//     }
//   }
// }