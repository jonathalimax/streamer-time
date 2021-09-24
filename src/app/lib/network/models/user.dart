import 'package:twitch_api/twitch_api.dart';

class User {
  final String id;
  final String name;
  final String profileImageUrl;

  User({
    required this.id,
    required this.name,
    required this.profileImageUrl,
  });

  User.fromTwitch({required TwitchUser twitchUser})
      : id = twitchUser.id,
        name = twitchUser.displayName,
        profileImageUrl = twitchUser.profileImageUrl;

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        profileImageUrl = json['profileImageUrl'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'profileImageUrl': profileImageUrl,
      };
}
