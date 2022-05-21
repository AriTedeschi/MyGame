import 'package:my_game/core/auth/auth_controller.dart';
import 'package:my_game/data/model/user_model.dart';
import 'package:my_game/domain/entity/user.dart';
import 'package:my_game/domain/usecases/save_user.dart';

class RegisterBloc {
  final AuthController authController;
  final SaveUser saveUser;

  RegisterBloc({required this.authController, required this.saveUser});

  register(User user, String password, context) async {
    await authController.register(user.email, password, context);
    final userModel = UserModel(
      uid: authController.user!.uid,
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      username: "",
    );
    authController.logout();
    saveUser.execute(userModel);
  }
}