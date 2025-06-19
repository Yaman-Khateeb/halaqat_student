import 'package:flutter/material.dart';
class MonthSelector extends StatefulWidget {
  final DateTime initialDate;
  final Future<bool> Function(DateTime newDate) canNavigateToMonth;
  final void Function(DateTime newDate) onMonthChanged;

  const MonthSelector({
    super.key,
    required this.initialDate,
    required this.canNavigateToMonth,
    required this.onMonthChanged,
  });

  @override
  _MonthSelectorState createState() => _MonthSelectorState();
}

class _MonthSelectorState extends State<MonthSelector> {
  late DateTime _currentDate;

  @override
  void initState() {
    super.initState();
    _currentDate = widget.initialDate;
  }

  Future<void> _changeMonth(int offset) async {
    int newYear;
    int newMonth;
    if(_currentDate.month + offset < 1)
    {
      newMonth = 12;
      newYear = _currentDate.year - 1;
    }
    else if(_currentDate.month + offset > 12)
    {
      newMonth = 1;
      newYear = _currentDate.year + 1;
    }
    else
    {
      newMonth = _currentDate.month + offset;
      newYear = _currentDate.year;
    }
    final newDate = DateTime(newYear, newMonth);
    final canNavigate = await widget.canNavigateToMonth(newDate); //We used await because the canNavigateToMonth should go to database and check in data to see if there is some records in the month we want to navigate to (month before or month after)

    if (canNavigate) {
      setState(() => _currentDate = newDate);
      widget.onMonthChanged(_currentDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final monthName = _getArabicMonth(_currentDate.month);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_left),
          onPressed: () => _changeMonth(1),
        ),
        Text(
          '$monthName ${_currentDate.year}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        IconButton(
          icon: const Icon(Icons.arrow_right),
          onPressed: () => _changeMonth(-1),
        ),
      ],
    );
  }

  String _getArabicMonth(int month) {
    const arabicMonths = [
      'الشهر الأول', 'الشهر الثاني', 'الشهر الثالث', 'الشهر الرابع', 'الشهر الخامس', 'الشهر السادس',
      'الشهر السابع', 'الشهر الثامن', 'الشهر التاسع', 'الشهر العاشر', 'الشهر الحادي عشر', 'الشهر الثاني عشر'
    ];
    return arabicMonths[month - 1];
  }
}
