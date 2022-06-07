import 'package:dartz/dartz.dart';
import 'package:my_game/core/error/failure.dart';
import 'package:my_game/data/model/post_model.dart';
import 'package:my_game/domain/repository/post_repository.dart';
import 'package:my_game/domain/usecases/use_case.dart';

class GetAllPosts extends UseCase<List<PostModel>, NoParams> {
  final PostRepository postRepository;

  GetAllPosts({required this.postRepository});

  @override
  Future<Either<Failure, List<PostModel>>> execute(NoParams param) {
    return postRepository.getAll();
  }
}
