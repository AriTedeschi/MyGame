import 'package:dartz/dartz.dart';
import 'package:my_game/core/error/failure.dart';
import 'package:my_game/data/model/game_model.dart';

abstract class GameRepository {
  Future<Either<Failure, List<GameModel>>> getAll();

  Future<Either<Failure, GameModel?>> getById(String id);
}
