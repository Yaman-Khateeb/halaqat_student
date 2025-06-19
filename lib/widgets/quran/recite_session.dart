import 'package:flutter/material.dart';
import 'package:himmah_tracker/modules/reciteSession.dart';
import 'package:intl/intl.dart';
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
                 Text('العلامة: ${widget.reciteSession.grade}'),
              ],
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
                  child: Text(
                    (widget.reciteSession.description == null)? 'لا يوجد ملاحظات': widget.reciteSession.description!,                    
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
