import 'package:dartz/dartz.dart';
import 'package:my_game/core/error/failure.dart';
import 'package:my_game/data/model/game_model.dart';
import 'package:my_game/domain/repository/game_repository.dart';
import 'package:my_game/domain/usecases/use_case.dart';

class GetAllGames extends UseCase<List<GameModel>, NoParams> {
  final GameRepository gameRepository;

  GetAllGames({required this.gameRepository});

  @override
  Future<Either<Failure, List<GameModel>>> execute(NoParams param) {
    return gameRepository.getAll();
  }
}