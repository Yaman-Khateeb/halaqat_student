import 'package:flutter/material.dart';
import 'package:himmah_tracker/modules/attendance.dart';
import 'package:intl/intl.dart';
class AttendanceRecore extends StatelessWidget {
  const AttendanceRecore(this.attendance,{super.key});
  final Attendance attendance;
  @override
  Widget build(BuildContext context) {
    final dateFormated = DateFormat('dd/MM/yyyy').format(attendance.date);
    return 
       Card(
        margin: const EdgeInsets.symmetric(vertical:12),
        elevation: 4,
        color:(attendance.didAttended)? const Color.fromARGB(232, 212, 248, 232) : const Color.fromRGBO(241, 234, 234, 1),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(dateFormated,style: Theme.of(context).textTheme.titleSmall,),
              const Spacer(),
              Text((attendance.didAttended)?'حضور': 'غياب',style: Theme.of(context).textTheme.titleMedium,),
              const SizedBox(width: 10,),
              Icon((attendance.didAttended)?Icons.check : Icons.close, color:(attendance.didAttended)? Colors.green : const Color.fromARGB(190, 144, 1, 1),size:20,)
            ],
          ),
        ),      
    );
  }
}