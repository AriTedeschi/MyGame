import 'dart:convert';

import 'package:my_game/data/model/user_model.dart';
import 'package:my_game/domain/entity/reply.dart';

class ReplyModel {
  UserModel user;
  String description;

  ReplyModel({required this.user, required this.description});

  factory ReplyModel.fromMap(Map<String, dynamic> map) {
    return ReplyModel(
      user: map['user'],
      description: map['description'],
    );
  }

  factory ReplyModel.fromJson(String json) =>
      ReplyModel.fromMap(jsonDecode(json));

  Map<String, dynamic> toMap() => {
        "user": user,
        "description": description,
      };

  String toJson() => jsonEncode(toMap());

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
}
