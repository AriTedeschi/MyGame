import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:my_game/core/error/failure.dart';
import 'package:my_game/data/model/post_model.dart';

abstract class PostRepository {
  Future<Either<Failure, List<PostModel>>> getByName(String name);

  Future<Either<Failure, DocumentReference>> save(PostModel postModel);
}