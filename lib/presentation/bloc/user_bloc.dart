import 'package:my_game/core/auth/auth_controller.dart';
import 'package:my_game/domain/usecases/get_user.dart';
import 'package:my_game/domain/usecases/save_user.dart';

class UserBloc {
  final AuthController authController;
  final SaveUser saveUser;
  final GetUser getUser;

  UserBloc(
      {required this.authController,
      required this.saveUser,
      required this.getUser});

  updateUsername(String username) async {
    final result = await getUser.execute(authController.user!.uid);
    result.fold((failure) {}, (userModel) {
      userModel!.username = username;
      saveUser.execute(userModel);
    });
  }
}