import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_game/data/model/game_model.dart';
import 'package:my_game/data/model/reply_model.dart';
import 'package:my_game/data/model/user_model.dart';
import 'package:my_game/domain/entity/post.dart';

class PostModel {
  String id;
  String title;
  String description;
  UserModel user;
  Timestamp created;
  GameModel game;
  List<ReplyModel> replies;

  PostModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.user,
      required this.created,
      required this.game,
      required this.replies});

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      user: UserModel.fromMap(map['user']),
      created: map['created'],
      game: GameModel.fromMap(map['game']),
      replies: ReplyModel.fromMapList(map['replies']),
    );
  }

  factory PostModel.fromJson(String json) =>
      PostModel.fromMap(jsonDecode(json));

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "description": description,
        "user": user.toMap(),
        "created": created,
        "game": game.toMap(),
        "replies": replies
      };

  String toJson() => jsonEncode(toMap());

  static List<Post> toDomainList(List<PostModel> postModelList) {
    List<Post> postList = <Post>[];
    for (var postModel in postModelList) {
      postList.add(toDomain(postModel));
    }
    return postList;
  }

  static Post toDomain(PostModel postModel) {
    return Post(
      id: postModel.id,
      title: postModel.title,
      description: postModel.description,
      username: postModel.user.username,
      created: postModel.created,
      game: postModel.game.name,
      replies: ReplyModel.toDomainList(postModel.replies),
    );
  }
}
