class Follower {
  final String userId;
  final String username;

  Follower({
    required this.userId,
    required this.username,
  });

  Follower.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        username = json['username'];

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'username': username,
      };
}
