import 'package:my_game/core/error/failure.dart';
import 'package:my_game/data/model/post_model.dart';
import 'package:my_game/domain/entity/post.dart';
import 'package:my_game/domain/usecases/get_all_posts.dart';
import 'package:my_game/domain/usecases/use_case.dart';

class PostBloc {
  final GetAllPosts getAllPosts;

  PostBloc({required this.getAllPosts});

  Future<List<Post>> findAll() async {
    try {
      List<Post> postList = <Post>[];
      final result = await getAllPosts.execute(NoParams());
      result.fold((failure) {}, (postModelList) {
        postList = PostModel.toDomainList(postModelList);
      });

      return postList;
    } on DatabaseFailure catch (e) {
      throw DatabaseFailure(e.message);
    }
  }
}