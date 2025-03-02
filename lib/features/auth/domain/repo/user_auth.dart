//step 1 create the model
//create abstract class
//step 2

import 'package:socialmedia_app/features/auth/domain/entites/user_app.dart';

abstract class AuthRepo {
  Future<AppUser?> loginWithEmailAndPassword(String email, String password);
  Future<AppUser?> signUpWithEmailAndPassword(
      String email, String password, String name);
  Future<void> logout();
  Future<AppUser?> getCurrentUser();
}
