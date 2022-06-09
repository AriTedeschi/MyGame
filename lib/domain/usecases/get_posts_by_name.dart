import 'package:dartz/dartz.dart';
import 'package:my_game/core/error/failure.dart';
import 'package:my_game/data/model/post_model.dart';
import 'package:my_game/domain/repository/post_repository.dart';
import 'package:my_game/domain/usecases/use_case.dart';

class GetPostsByName extends UseCase<List<PostModel>, String> {
  final PostRepository postRepository;

  GetPostsByName({required this.postRepository});

  @override
  Future<Either<Failure, List<PostModel>>> execute(String param) {
    return postRepository.getByName(param);
  }
}
