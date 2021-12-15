import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Event {
  String? id;
  String title;
  DateTime starTime;
  String categoryId;
  String categoryName;
  String? imageUrl;
  String? duration;
  String timezone;
  bool isRecurring;

  String get dateDisplay => DateFormat('dd MMM').format(starTime);
  String get timeDisplay => DateFormat('jm').format(starTime);

  bool get isLive {
    final now = DateTime.now();
    return starTime.isBefore(now) &&
        starTime.difference(now) <= Duration(hours: 4);
  }

  Event({
    this.id,
    required this.title,
    required this.starTime,
    required this.categoryId,
    required this.categoryName,
    this.imageUrl,
    this.duration,
    this.isRecurring = false,
  }) : timezone = DateTime.now().timeZoneName;

  Event.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        starTime = (json['starTime'] as Timestamp).toDate(),
        categoryId = json['categoryId'],
        categoryName = json['categoryName'],
        imageUrl = json['imageUrl'],
        duration = json['duration'],
        timezone = json['timezone'],
        isRecurring = json['isRecurring'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'starTime': starTime,
        'categoryId': categoryId,
        'categoryName': categoryName,
        'imageUrl': imageUrl,
        'duration': duration,
        'timezone': timezone,
        'isRecurring': isRecurring,
      };
}
