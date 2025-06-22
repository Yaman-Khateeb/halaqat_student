import 'package:flutter/material.dart';
import 'package:himmah_tracker/modules/reciteSession.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
class ReciteSessionWidget extends StatefulWidget {
   const ReciteSessionWidget(this.reciteSession,{super.key});
  final ReciteSession reciteSession;
  @override
  State<ReciteSessionWidget> createState() => _ReciteSessionWidgetState();
}

class _ReciteSessionWidgetState extends State<ReciteSessionWidget>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  late String formatedDate;
  @override
  void initState() {
    super.initState();
    formatedDate = DateFormat('d/M/y').format(widget.reciteSession.date);
  }
   

  @override
  Widget build(BuildContext context) {
   final evaluationPoints = widget.reciteSession.evaluationPoints!;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
      elevation: 4,
      color: const Color.fromRGBO(224, 235, 236, 100),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                Text(formatedDate),
                Text('عدد الصفحات: ${widget.reciteSession.pagesAmount}'),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  icon: Icon(
                    isExpanded
                        ? Icons.expand_less
                        : Icons.expand_more,
                  ),
                ),
             Directionality(
  textDirection: ui.TextDirection.rtl,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const Text(
        'العلامة:',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      const SizedBox(width: 8),
      Chip(
        label: Text(
          '${widget.reciteSession.evaluationPoints ?? 0}',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: (evaluationPoints > 70)? const Color.fromARGB(207, 67, 160, 113) : (evaluationPoints > 50)? const Color.fromARGB(255, 232, 141, 13) : const Color.fromARGB(255, 193, 66, 57),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      ),
      const SizedBox(width: 8),
      Text(
        '${widget.reciteSession.evaluationTitle ?? ''}',
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black87,
        ),
      ),
    ],
  ),
)

              ],
              //Text('العلامة: ${widget.reciteSession.evaluationPoints??0} ${widget.reciteSession.evaluationTitle??''}')),
            ),
            AnimatedSize(
  duration: const Duration(milliseconds: 300),
  curve: Curves.easeInOut,
  child: ConstrainedBox(
    constraints: isExpanded
        ? const BoxConstraints()
        : const BoxConstraints(maxHeight: 0),
    child: Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Directionality(
        textDirection: ui.TextDirection.ltr,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end, // Align to right
          children: [
           const  Directionality(
              textDirection: ui.TextDirection.rtl,

              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                'الأخطاء:',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              ) 
            ),
            const SizedBox(height: 8),
            (widget.reciteSession.mistakes.isEmpty)
                ? const Directionality(
                  textDirection: ui.TextDirection.rtl,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'لا توجد أخطاء في هذه الجلسة.',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ) 
                )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.reciteSession.mistakes.length,
                    itemBuilder: (context, index) {
                      final mistake = widget.reciteSession.mistakes[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '${mistake.title}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'الصفحة: ${mistake.page}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    ),
  ),
)

          ],
        ),
      ),
    );
  }
}
