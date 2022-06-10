import 'package:dartz/dartz.dart';
import 'package:my_game/core/error/failure.dart';
import 'package:my_game/data/model/post_model.dart';
import 'package:my_game/domain/repository/post_repository.dart';
import 'package:my_game/domain/usecases/use_case.dart';

class GetPostById extends UseCase<PostModel, String> {
  final PostRepository postRepository;

  GetPostById({required this.postRepository});

  @override
  Future<Either<Failure, PostModel>> execute(String param) {
    return postRepository.getById(param);
  }
}
