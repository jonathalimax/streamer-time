import 'package:app/network/models/event.dart';
import 'package:twitch_api/twitch_api.dart';

class User {
  final String id;
  final String name;
  final String profileImageUrl;
  final String? description;
  late bool following;
  List<Event> events = [];

  User({
    required this.id,
    required this.name,
    required this.profileImageUrl,
    this.description = '',
    this.following = false,
  });

  User.fromTwitch({required TwitchUser twitchUser})
      : id = twitchUser.id,
        name = twitchUser.displayName,
        profileImageUrl = twitchUser.profileImageUrl,
        description = twitchUser.description;

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        profileImageUrl = json['profileImageUrl'],
        description = json['description'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'profileImageUrl': profileImageUrl,
        'description': description,
      };
}
