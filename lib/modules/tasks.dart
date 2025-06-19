enum enTaskType {
  azkar,
  quran,
  prayer,
  general,
  studying,
  }

  class Tasks
   {
    const Tasks({required this.title,this.description, required this.type, this.amount ,this.amountTypeDescription,});
    final String title;
    final String? description;
    final enTaskType type;
    final int? amount;
    final String? amountTypeDescription;
   }