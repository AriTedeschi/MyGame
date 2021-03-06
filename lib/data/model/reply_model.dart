import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_game/data/model/user_model.dart';
import 'package:my_game/domain/entity/reply.dart';

class ReplyModel {
  UserModel user;
  String description;

  ReplyModel({required this.user, required this.description});

  factory ReplyModel.fromMap(Map<String, dynamic> map) {
    return ReplyModel(
      user: UserModel.fromMap(map['user']),
      description: map['description'],
    );
  }

  factory ReplyModel.fromJson(String json) =>
      ReplyModel.fromMap(jsonDecode(json));

  Map<String, dynamic> toMap() => {
        "user": user.toMap(),
        "description": description,
      };

  String toJson() => jsonEncode(toMap());

  static List<ReplyModel> fromMapList(List<dynamic> map) {
    List<ReplyModel> replyModelList = <ReplyModel>[];
    for (var element in map) {
      replyModelList.add(ReplyModel.fromMap(element));
    }
    return replyModelList;
  }

  static List<Reply> toDomainList(List<ReplyModel> replyModelList) {
    List<Reply> replyList = <Reply>[];
    for (var replyModel in replyModelList) {
      replyList.add(toDomain(replyModel));
    }
    return replyList;
  }

  static Reply toDomain(ReplyModel replyModel) {
    return Reply(
      username: replyModel.user.username,
      description: replyModel.description,
    );
  }

  Map<String, dynamic> toMapList() {
    return {
      'replies': FieldValue.arrayUnion([
        {
          "user": user.toMap(),
          "description": description,
        },
      ]),
    };
  }
}
