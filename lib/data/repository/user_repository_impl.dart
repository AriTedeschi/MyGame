import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:my_game/core/error/failure.dart';
import 'package:my_game/data/model/user_model.dart';
import 'package:my_game/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('user');

  @override
  Future<Either<Failure, UserModel?>> get(String uid) async {
    try {
      final snapShot = await collection.where("uid", isEqualTo: uid).get();
      final docs = snapShot.docs;
      if (docs.isEmpty) {
        return right(null);
      }
      final map = UserModel.fromMap(docs.single.data() as Map<String, dynamic>);
      return right(map);
    } catch (e) {
      return left(throw const DatabaseFailure("Error getting from Database"));
    }
  }

  @override
  Future<Either<Failure, DocumentReference>> save(UserModel userModel) async {
    try {
      DocumentReference documentReference = collection.doc(userModel.uid);
      documentReference.set(userModel.toMap());
      return right(documentReference);
    } catch (e) {
      return left(throw const DatabaseFailure("Error saving on Database"));
    }
  }
}
