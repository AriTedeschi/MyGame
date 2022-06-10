import 'package:my_game/core/error/failure.dart';
import 'package:my_game/data/model/game_model.dart';
import 'package:my_game/domain/entity/game.dart';
import 'package:my_game/domain/usecases/get_all_games.dart';
import 'package:my_game/domain/usecases/get_game.dart';
import 'package:my_game/domain/usecases/use_case.dart';

class GameBloc {
  final GetGame getGame;
  final GetAllGames getAllGames;

  GameBloc({required this.getGame, required this.getAllGames});

  Future<List<Game>> findAll() async {
    try {
      List<Game> gameList = <Game>[];
      final result = await getAllGames.execute(NoParams());
      result.fold((failure) {}, (gameModelList) {
        gameList = GameModel.toDomainList(gameModelList);
      });

      return gameList;
    } on DatabaseFailure catch (e) {
      throw DatabaseFailure(e.message);
    }
  }
}
