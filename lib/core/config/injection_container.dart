import 'package:get_it/get_it.dart';
import 'package:my_game/data/repository/game_repository_impl.dart';
import 'package:my_game/data/repository/post_repository_impl.dart';
import 'package:my_game/data/repository/user_repository_impl.dart';
import 'package:my_game/domain/repository/game_repository.dart';
import 'package:my_game/domain/repository/post_repository.dart';
import 'package:my_game/domain/repository/user_repository.dart';
import 'package:my_game/domain/usecases/add_post_reply.dart';
import 'package:my_game/domain/usecases/get_all_games.dart';
import 'package:my_game/domain/usecases/get_post_by_id.dart';
import 'package:my_game/domain/usecases/get_posts_by_name.dart';
import 'package:my_game/domain/usecases/get_game.dart';
import 'package:my_game/domain/usecases/get_user.dart';
import 'package:my_game/domain/usecases/save_post.dart';
import 'package:my_game/domain/usecases/save_user.dart';
import 'package:my_game/core/auth/auth_controller.dart';
import 'package:my_game/presentation/bloc/game_bloc.dart';
import 'package:my_game/presentation/bloc/login_bloc.dart';
import 'package:my_game/presentation/bloc/post_bloc.dart';
import 'package:my_game/presentation/bloc/register_bloc.dart';
import 'package:my_game/presentation/bloc/user_bloc.dart';

final sl = GetIt.instance;

void init() {
  // Feature - Login and Register
  // Bloc
  sl.registerFactory(() =>
      LoginBloc(
        getUser: sl(),
        authController: sl(),
        saveUser: sl(),
      ));
  sl.registerFactory(() =>
      RegisterBloc(
        authController: sl(),
        saveUser: sl(),
      ));
  sl.registerFactory(() =>
      UserBloc(
        authController: sl(),
        saveUser: sl(),
        getUser: sl(),
      ));
  // Controller
  sl.registerLazySingleton(() => AuthController());
  // UseCases
  sl.registerLazySingleton(() => GetUser(userRepository: sl()));
  sl.registerLazySingleton(() => SaveUser(userRepository: sl()));
  // Repository
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());

  // Feature - Games
  sl.registerFactory(() =>
      GameBloc(
        getGame: sl(),
        getAllGames: sl(),
      ));
  // UseCases
  sl.registerLazySingleton(() => GetGame(gameRepository: sl()));
  sl.registerLazySingleton(() => GetAllGames(gameRepository: sl()));
  //Repository
  sl.registerLazySingleton<GameRepository>(() => GameRepositoryImpl());

  // Feature - Posts
  sl.registerFactory(() =>
      PostBloc(
        getPostsByName: sl(),
        authController: sl(),
        savePost: sl(),
        getPostById: sl(),
        addPostReply: sl(),
      ));
  // UseCases
  sl.registerLazySingleton(() => GetPostById(postRepository: sl()));
  sl.registerLazySingleton(() => GetPostsByName(postRepository: sl()));
  sl.registerLazySingleton(() => SavePost(postRepository: sl()));
  sl.registerLazySingleton(() => AddPostReply(postRepository: sl()));
  //Repository
  sl.registerLazySingleton<PostRepository>(() => PostRepositoryImpl());
}
