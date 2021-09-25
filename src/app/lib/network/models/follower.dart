class Follower {
  final String userId;

  Follower({
    required this.userId,
  });

  Follower.fromJson(Map<String, dynamic> json) : userId = json['userId'];

  Map<String, dynamic> toJson() => {
        'userId': userId,
      };
}
