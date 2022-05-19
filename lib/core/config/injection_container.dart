import 'package:get_it/get_it.dart';
import 'package:my_game/data/repository/user_repository_impl.dart';
import 'package:my_game/domain/repository/user_repository.dart';
import 'package:my_game/domain/usecases/get_user.dart';
import 'package:my_game/domain/usecases/save_user.dart';
import 'package:my_game/presentation/controller/auth_controller.dart';
import 'package:my_game/presentation/controller/login_controller.dart';

final sl = GetIt.instance;

void init() {
  // Feature - Login
  // Controller
  sl.registerFactory(() => AuthController());
  sl.registerFactory(() => LoginController(
      getUser: sl(),
      authController: sl(),
      saveUser: sl()),
  );
  // UseCases
  sl.registerLazySingleton(() => GetUser(userRepository: sl()));
  sl.registerLazySingleton(() => SaveUser(userRepository: sl()));
  // Repository
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());
  
}
