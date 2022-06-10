import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:my_game/core/error/failure.dart';
import 'package:my_game/data/model/post_model.dart';
import 'package:my_game/domain/repository/post_repository.dart';
import 'package:my_game/domain/usecases/add_post_reply.dart';

class PostRepositoryImpl implements PostRepository {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('post');

  @override
  Future<Either<Failure, PostModel>> getById(String id) async {
    try {
      final snapShot = await collection.where('id', isEqualTo: id).get();
      final docs = snapShot.docs;
      final postModel =
          PostModel.fromMap(docs.single.data() as Map<String, dynamic>);
      return right(postModel);
    } catch (e) {
      return left(throw const DatabaseFailure("Error getting from Database"));
    }
  }

  @override
  Future<Either<Failure, List<PostModel>>> getByName(String name) async {
    try {
      List<PostModel> postModels = <PostModel>[];
      final snapShot = await collection
          .where('game.name', isEqualTo: name)
          .orderBy('created', descending: true)
          .get();
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

  @override
  Future<Either<Failure, DocumentReference>> save(PostModel postModel) async {
    try {
      var count = await _autoIncrement();
      postModel.id = count.toString();

      DocumentReference documentReference = collection.doc(postModel.id);
      documentReference.set(postModel.toMap());
      return right(documentReference);
    } catch (e) {
      return left(throw const DatabaseFailure("Error saving on Database"));
    }
  }

  @override
  Future<Either<Failure, DocumentReference>> addReply(
      AddReplyModel addReplyModel) async {
    try {
      DocumentReference documentReference =
          collection.doc(addReplyModel.postId);
      documentReference.update(addReplyModel.replyModel.toMapList());
      return right(documentReference);
    } catch (e) {
      return left(throw const DatabaseFailure("Error saving on Database"));
    }
  }

  Future<int> _autoIncrement() async {
    final snapShot = await collection.where('id', isEqualTo: '0').get();
    final element = snapShot.docs.single.data() as Map<String, dynamic>;
    int counter = element['counter'] + 1;
    DocumentReference documentReference = collection.doc("0");
    documentReference.update({'counter': counter});
    return counter;
  }
}
