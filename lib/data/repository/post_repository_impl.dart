import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:my_game/core/error/failure.dart';
import 'package:my_game/data/model/post_model.dart';
import 'package:my_game/domain/repository/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('post');

  @override
  Future<Either<Failure, List<PostModel>>> getByName(String name) async {
    try {
      List<PostModel> postModels = <PostModel>[];
      final snapShot = await collection
          .where('game.name', isEqualTo: name)
          .orderBy('created')
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
      int id = await _autoIncrement();
      DocumentReference documentReference = collection.doc(id.toString());
      documentReference.set(postModel.toMap());
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
