import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_game/domain/entity/reply.dart';

class Post {
  String title;
  String description;
  String username;
  Timestamp created;
  String game;
  List<Reply> replies;

  Post(
      {required this.title,
      required this.description,
      required this.username,
      required this.created,
      required this.game,
      required this.replies});
}
