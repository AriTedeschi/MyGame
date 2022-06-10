import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:my_game/core/error/failure.dart';
import 'package:my_game/data/model/reply_model.dart';
import 'package:my_game/domain/repository/post_repository.dart';
import 'package:my_game/domain/usecases/use_case.dart';

class AddPostReply extends UseCase<DocumentReference, AddReplyModel> {
  final PostRepository postRepository;

  AddPostReply({required this.postRepository});

  @override
  Future<Either<Failure, DocumentReference>> execute(AddReplyModel param) {
    return postRepository.addReply(param);
  }
}

class AddReplyModel {
  final String postId;
  final ReplyModel replyModel;

  AddReplyModel({required this.postId, required this.replyModel});
}
