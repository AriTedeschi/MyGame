import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:my_game/core/error/failure.dart';
import 'package:my_game/data/model/post_model.dart';
import 'package:my_game/domain/repository/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('post');

  @override
  Future<Either<Failure, List<PostModel>>> getAll() async {
    try {
      List<PostModel> postModels = <PostModel>[];
      final snapShot = await collection.orderBy('created').get();
      final docs = snapShot.docs;
      for (var element in docs) {
        final map = PostModel.fromMap(element.data() as Map<String, dynamic>);
        postModels.add(map);
      }
      return right(postModels);
    } catch (e) {
      return left(throw const DatabaseFailure("Error getting from Database"));
    }
  }
}
