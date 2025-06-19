class Campaign {
  final int id;
  final String name;
  final DateTime startDate;
  final List<String> days;
  final String startTime;
  final String endTime;

  Campaign({
    required this.id,
    required this.name,
    required this.startDate,
    required this.days,
    required this.startTime,
    required this.endTime,
  });

  // factory Campaign.fromJson(Map<String, dynamic> json) {
  //   return Campaign(
  //     id: json['id'],
  //     name: json['name'],
  //     startDate: DateTime.parse(json['startDate']),
  //     days: (json['days'] as String).split(','),
  //     startTime: json['startTime'],
  //     endTime: json['endTime'],
  //   );
  // }
}
