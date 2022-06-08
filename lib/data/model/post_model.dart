import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_game/data/model/game_model.dart';
import 'package:my_game/data/model/reply_model.dart';
import 'package:my_game/data/model/user_model.dart';
import 'package:my_game/domain/entity/post.dart';

class PostModel {
  String title;
  String description;
  UserModel user;
  Timestamp created;
  GameModel game;
  List<ReplyModel> replies;

  PostModel(
      {required this.title,
      required this.description,
      required this.user,
      required this.created,
      required this.game,
      required this.replies});

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
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
        "title": title,
        "description": description,
        "user": user,
        "created": created,
        "game": game,
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
      title: postModel.title,
      description: postModel.description,
      username: postModel.user.username,
      created: postModel.created,
      game: postModel.game.name,
      replies: ReplyModel.toDomainList(postModel.replies),
    );
  }
}
