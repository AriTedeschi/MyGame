import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:my_game/core/error/failure.dart';
import 'package:my_game/data/model/game_model.dart';
import 'package:my_game/domain/repository/game_repository.dart';

class GameRepositoryImpl implements GameRepository {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('game');

  @override
  Future<Either<Failure, List<GameModel>>> getAll() async {
    try {
      List<GameModel> gameModels = <GameModel>[];

      final snapShot = await collection.get();
      final docs = snapShot.docs;
      for (var element in docs) {
        final map = GameModel.fromMap(element.data() as Map<String, dynamic>);
        gameModels.add(map);
      }

      return right(gameModels);
    } catch (e) {
      return left(throw const DatabaseFailure("Error getting from Database"));
    }
  }

  @override
  Future<Either<Failure, GameModel?>> getById(String id) async {
    try {
      final snapShot = await collection.where("id", isEqualTo: id).get();
      final docs = snapShot.docs;
      if (docs.isEmpty) {
        return right(null);
      }
      final map = GameModel.fromMap(docs.single.data() as Map<String, dynamic>);
      return right(map);
    } catch (e) {
      return left(throw const DatabaseFailure("Error getting from Database"));
    }
  }
}
