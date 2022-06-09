import 'dart:convert';

import 'package:my_game/domain/entity/game.dart';

class GameModel extends Game {
  GameModel(
      {required int id, required String name, required String imageUrl,})
      : super(id: id, name: name, imageUrl: imageUrl);

  factory GameModel.fromMap(Map<String, dynamic> map) {
    return GameModel(
      id: map['id'],
      name: map['name'],
      imageUrl: map['imageUrl'],
    );
  }

  factory GameModel.fromJson(String json) =>
      GameModel.fromMap(jsonDecode(json));

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "imageUrl": imageUrl,
      };

  String toJson() => jsonEncode(toMap());

  static List<Game> toDomainList(List<GameModel> gameModelList) {
    List<Game> gameList = <Game>[];
    for(var gameModel in gameModelList) {
      gameList.add(toDomain(gameModel));
    }
    return gameList;
  }

  static Game toDomain(GameModel gameModel) {
    return Game(
      id: gameModel.id,
      name: gameModel.name,
      imageUrl: gameModel.imageUrl,
    );
  }

  static GameModel toData(Game game) {
    return GameModel(
      id: game.id,
      name: game.name,
      imageUrl: game.imageUrl,
    );
  }
}
