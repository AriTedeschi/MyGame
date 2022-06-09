import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_game/core/auth/auth_controller.dart';
import 'package:my_game/core/error/failure.dart';
import 'package:my_game/data/model/game_model.dart';
import 'package:my_game/data/model/post_model.dart';
import 'package:my_game/data/model/user_model.dart';
import 'package:my_game/domain/entity/game.dart';
import 'package:my_game/domain/entity/post.dart';
import 'package:my_game/domain/entity/user.dart';
import 'package:my_game/domain/usecases/get_posts_by_name.dart';
import 'package:my_game/domain/usecases/save_post.dart';

class PostBloc {
  final GetPostsByName getPostsByName;
  final SavePost savePost;
  final AuthController authController;

  PostBloc({required this.getPostsByName, required this.savePost, required this.authController});

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

  save(Game game, User user, String title, String content) async {
    try {
      final timeStamp = DateTime.now().millisecondsSinceEpoch;
      final postModel = PostModel(
        title: title,
        description: content,
        user: UserModel.toData(authController.user!.uid, user),
        created: Timestamp.fromMillisecondsSinceEpoch(timeStamp),
        game: GameModel.toData(game),
        replies: List.empty(),
      );

      savePost.execute(postModel);
    } on DatabaseFailure catch (e) {
      throw DatabaseFailure(e.message);
    }
  }
}
