class ReciteSession {
  final int id;
  final int start;
  final int end;
  final int duration;
  final DateTime date;
  final String? evaluationTitle;
  final int? evaluationPoints;
  final List<Mistake> mistakes;
  final int pagesAmount;

  ReciteSession({
    required this.id,
    required this.start,
    required this.end,
    required this.duration,
    required this.date,
    this.evaluationTitle,
    this.evaluationPoints,
    required this.mistakes,
  }) : pagesAmount = (end - start + 1);

  factory ReciteSession.fromJson(Map<String, dynamic> json) {
    return ReciteSession(
      id: json['id'],
      start: json['start'],
      end: json['end'],
      duration: json['duration'],
      date: DateTime.parse(json['created_at']),
      evaluationTitle: json['evaluation']?['title'],
      evaluationPoints: json['evaluation']?['points'],
      mistakes: (json['mistakes'] as List<dynamic>)
          .map((e) => Mistake.fromJson(e))
          .toList(),
    );
  }
}

class Mistake {
  final String title;
  final int page;

  Mistake({required this.title, required this.page});

  factory Mistake.fromJson(Map<String, dynamic> json) {
    return Mistake(
      title: json['title'].toString(),
      page: json['page'],
    );
  }
}
