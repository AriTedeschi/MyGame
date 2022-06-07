import 'package:dartz/dartz.dart';
import 'package:my_game/core/error/failure.dart';
import 'package:my_game/data/model/game_model.dart';
import 'package:my_game/domain/repository/game_repository.dart';
import 'package:my_game/domain/usecases/use_case.dart';

class GetGame extends UseCase<GameModel?, String> {
  final GameRepository gameRepository;

  GetGame({required this.gameRepository});

  @override
  Future<Either<Failure, GameModel?>> execute(String param) {
    return gameRepository.getById(param);
  }
}
