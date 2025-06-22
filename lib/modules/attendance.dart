enum Status{
  attended,
  late,
  absent
}

class Attendance {

  Attendance({required this.id,required this.date, required this.status,required this.delayTime}) : didAttended = (status == Status.attended || status == Status.late);
  int id; 
  DateTime date;
  Status status;
  bool didAttended;
  int delayTime;
  factory Attendance.fromJson(Map<String,dynamic> json)
  {
    final attendStatusString = json['status'];
     Status status = Status.absent;
    switch (attendStatusString.toUpperCase()) {
  case 'ATTEND':
    status = Status.attended;
    break;
  case 'DELAY':
    status = Status.late;
    break;
  case 'MISSED':
    status = Status.absent;
    break;
  default:
    status = Status.absent;
}
    return Attendance(id: json['id'], date: DateTime.parse(json['takenDate']), status: status, delayTime: json['delayTime']);
  }
}