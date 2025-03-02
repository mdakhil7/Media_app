//here we will implement the
import 'package:firebase_auth/firebase_auth.dart';
import 'package:socialmedia_app/features/auth/domain/entites/user_app.dart';
import 'package:socialmedia_app/features/auth/domain/repo/user_auth.dart';

class FirebaseAuthRepo implements AuthRepo {
  final FirebaseAuth firebase = FirebaseAuth.instance;

  @override
  Future<AppUser?> getCurrentUser() async {
    final firebaseUser = firebase.currentUser;

    if (firebaseUser == null) {
      return null;
    }
    return AppUser(
      uid: firebaseUser.uid,
      name: '',
      email: firebaseUser.email!,
    );
  }

  @override
  Future<AppUser?> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await firebase.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      //now we will create the user using AppUser
      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        name: '',
        email: email,
      );

      return user;
    } catch (e) {
      throw Exception(
        'Login Failed: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> logout() async {
    await firebase.signOut();
  }

  @override
  Future<AppUser?> signUpWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      UserCredential userCredential =
          await firebase.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      //now we will create the user using AppUser
      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        name: name,
        email: email,
      );

      return user;
    } catch (e) {
      throw Exception(
        'Login Failed: ${e.toString()}',
      );
    }
  }
}
