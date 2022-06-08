import 'package:my_game/core/error/failure.dart';
import 'package:my_game/data/model/post_model.dart';
import 'package:my_game/domain/entity/post.dart';
import 'package:my_game/domain/usecases/get_all_posts.dart';

class PostBloc {
  final GetPostsByName getPostsByName;

  PostBloc({required this.getPostsByName});

  Future<List<Post>> findByGame(String name) async {
    try {
      List<Post> postList = <Post>[];
      final result = await getPostsByName.execute(name);
      result.fold((failure) {}, (postModelList) {
        postList = PostModel.toDomainList(postModelList);
      });

      return postList;
    } on DatabaseFailure catch (e) {
      throw DatabaseFailure(e.message);
    }
  }
}