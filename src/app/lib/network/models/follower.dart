import 'package:cloud_firestore/cloud_firestore.dart';

class Follower {
  final DocumentReference userRef;

  Follower({
    required this.userRef,
  });

  Follower.fromJson(Map<String, dynamic> json) : userRef = json['userRef'];

  Map<String, dynamic> toJson() => {
        'userRef': userRef,
      };
}
