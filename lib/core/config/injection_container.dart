import 'package:get_it/get_it.dart';
import 'package:my_game/data/repository/user_repository_impl.dart';
import 'package:my_game/domain/repository/user_repository.dart';
import 'package:my_game/domain/usecases/get_user.dart';
import 'package:my_game/domain/usecases/save_user.dart';
import 'package:my_game/core/auth/auth_controller.dart';
import 'package:my_game/presentation/bloc/login_bloc.dart';

final sl = GetIt.instance;

void init() {
  // Feature - Login
  // Controller
  sl.registerFactory(() => LoginBloc(
      getUser: sl(),
      authController: sl(),
      saveUser: sl()),
  );
  sl.registerLazySingleton(() => AuthController());
  // UseCases
  sl.registerLazySingleton(() => GetUser(userRepository: sl()));
  sl.registerLazySingleton(() => SaveUser(userRepository: sl()));
  // Repository
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());
  
}
