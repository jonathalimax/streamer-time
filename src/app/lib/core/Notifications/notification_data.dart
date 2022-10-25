enum NotificationType { live }

class NotificationData {
  final String type;
  final String streamerId;
  final String username;

  NotificationData(
    this.type,
    this.streamerId,
    this.username,
  );

  NotificationData.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        streamerId = json['streamerId'],
        username = json['username'];
}
