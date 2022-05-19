import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:my_game/core/error/failure.dart';
import 'package:my_game/domain/usecases/use_case.dart';
import '../../data/model/user_model.dart';
import '../repository/user_repository.dart';

class SaveUser extends UseCase<DocumentReference, UserModel> {
  final UserRepository userRepository;

  SaveUser({required this.userRepository});

  @override
  Future<Either<Failure, DocumentReference>> execute(UserModel param) {
    return userRepository.save(param);
  }
}
