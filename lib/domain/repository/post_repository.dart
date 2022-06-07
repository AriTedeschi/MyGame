import 'package:dartz/dartz.dart';
import 'package:my_game/core/error/failure.dart';
import 'package:my_game/data/model/post_model.dart';

abstract class PostRepository {
  Future<Either<Failure, List<PostModel>>> getAll();
}