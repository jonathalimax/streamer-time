class Event {
  final String? id;
  final String title;
  final String starTime;
  final String categoryId;
  final String categoryName;
  final String timezone;
  final String? duration;
  final bool isRecurring;

  Event({
    this.id,
    required this.title,
    required this.starTime,
    required this.categoryId,
    required this.categoryName,
    this.duration,
    this.timezone = 'America/Sao_Paulo', // TODO: Get the users timezone
    this.isRecurring = false,
  });

  Event.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        starTime = json['starTime'],
        categoryId = json['categoryId'],
        categoryName = json['categoryName'],
        timezone = json['timezone'],
        duration = json['duration'],
        isRecurring = json['isRecurring'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'starTime': starTime,
        'categoryId': categoryId,
        'categoryName': categoryName,
        'timezone': timezone,
        'duration': duration,
        'isRecurring': isRecurring,
      };
}
