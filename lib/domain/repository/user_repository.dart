import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:my_game/core/error/failure.dart';
import 'package:my_game/data/model/user_model.dart';

abstract class UserRepository {
  Future<Either<Failure, UserModel?>> get(String uid);

  Future<Either<Failure, DocumentReference>> save(UserModel userModel);
}
