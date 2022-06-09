import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:my_game/core/error/failure.dart';
import 'package:my_game/data/model/post_model.dart';
import 'package:my_game/domain/repository/post_repository.dart';
import 'package:my_game/domain/usecases/use_case.dart';

class SavePost extends UseCase<DocumentReference, PostModel> {
  final PostRepository postRepository;

  SavePost({required this.postRepository});

  @override
  Future<Either<Failure, DocumentReference>> execute(PostModel param) {
    return postRepository.save(param);
  }
}
