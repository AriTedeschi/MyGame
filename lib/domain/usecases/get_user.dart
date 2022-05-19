import 'package:dartz/dartz.dart';
import 'package:my_game/core/error/failure.dart';
import 'package:my_game/data/model/user_model.dart';
import 'package:my_game/domain/repository/user_repository.dart';
import 'package:my_game/domain/usecases/use_case.dart';

class GetUser extends UseCase<UserModel?, String> {
  final UserRepository userRepository;

  GetUser({required this.userRepository});

  @override
  Future<Either<Failure, UserModel?>> execute(String param) {
    return userRepository.get(param);
  }
}
