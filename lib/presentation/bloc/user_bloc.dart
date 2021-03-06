import 'package:my_game/core/auth/auth_controller.dart';
import 'package:my_game/data/model/user_model.dart';
import 'package:my_game/domain/entity/user.dart';
import 'package:my_game/domain/usecases/get_user.dart';
import 'package:my_game/domain/usecases/save_user.dart';

import '../../core/error/failure.dart';

class UserBloc {
  final AuthController authController;
  final SaveUser saveUser;
  final GetUser getUser;

  UserBloc(
      {required this.authController,
      required this.saveUser,
      required this.getUser});

  Future<User> updateUsername(String username) async {
    User? user;
    final result = await getUser.execute(authController.user!.uid);
    result.fold((failure) {}, (userModel) {
      userModel!.username = username;
      saveUser.execute(userModel);
      user = UserModel.toDomain(userModel);
    });
    return user!;
  }

  Future<User> updateUser(User user) async {
    try {
      final userModel = UserModel.toData(authController.user!.uid, user);
      saveUser.execute(userModel);
      return user;
    } on DatabaseFailure catch (e) {
      throw DatabaseFailure(e.message);
    }
  }

  Future<User?> findUser() async {
    User? user;
    final result = await getUser.execute(authController.user!.uid);
    result.fold((failure) {}, (userModel) {
      user = UserModel.toDomain(userModel);
    });
    return user;
  }

  logout() {
    authController.logout();
  }

  bool isLoading() {
    return authController.isLoading;
  }
}
