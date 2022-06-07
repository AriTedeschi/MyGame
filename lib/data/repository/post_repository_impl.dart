import 'package:dartz/dartz.dart';
import 'package:my_game/core/error/failure.dart';
import 'package:my_game/data/model/post_model.dart';
import 'package:my_game/domain/repository/post_repository.dart';

class PostRepositoryImpl implements PostRepository {

  @override
  Future<Either<Failure, List<PostModel>>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

}