import 'package:app/network/models/event.dart';
import 'package:twitch_api/twitch_api.dart';

class User {
  final String id;
  final String name;
  final String username;
  final String profileImageUrl;
  final String? description;
  final int viewCount;
  List<String>? deviceToken = null;
  bool following = false;
  List<Event> events = [];

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.profileImageUrl,
    this.description = '',
    this.viewCount = 0,
  });

  User.fromTwitch({required TwitchUser twitchUser})
      : id = twitchUser.id,
        name = twitchUser.displayName,
        username = twitchUser.login,
        profileImageUrl = twitchUser.profileImageUrl,
        description = twitchUser.description,
        viewCount = twitchUser.viewCount;

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        username = json['username'],
        profileImageUrl = json['profileImageUrl'],
        description = json['description'],
        viewCount = json['viewCount'],
        deviceToken =
            json['deviceToken'] != null ? List.from(json['deviceToken']) : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'username': username,
        'profileImageUrl': profileImageUrl,
        'description': description,
        'viewCount': viewCount,
        'deviceToken': deviceToken,
      };
}
