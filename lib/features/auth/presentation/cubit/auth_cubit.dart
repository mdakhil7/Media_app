import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:socialmedia_app/features/auth/domain/entites/user_app.dart';
import 'package:socialmedia_app/features/auth/domain/repo/user_auth.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AppUser? _currentUser;

  AuthCubit({required this.authRepo}) : super(AuthInitial());

  // Check if user is authenticated
  void checkAuth() async {
    final AppUser? user = await authRepo.getCurrentUser();

    if (user != null) {
      _currentUser = user;
      emit(Authenticated(user)); // ✅ Always emit the correct state
    } else {
      emit(UnAuthenticated());
    }
  }

  // Get the current user
  AppUser? get currentUser => _currentUser;

  // Login user
  Future<void> loginUser(String email, String password) async {
    try {
      emit(AuthLoading());
      final user = await authRepo.loginWithEmailAndPassword(email, password);

      if (user != null) {
        _currentUser = user; // ✅ Update currentUser
        emit(Authenticated(user));
      } else {
        emit(UnAuthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(UnAuthenticated());
    }
  }

  // Register user
  // Future<void> registerUser(String name, String email, String password) async {
  //   try {
  //     emit(AuthLoading());
  //     final user = await authRepo.signUpWithEmailAndPassword(email, password, name);

  //     if (user != null) {
  //       _currentUser = user;  // ✅ Update currentUser
  //       emit(Authenticated(user));
  //     } else {
  //       emit(UnAuthenticated());
  //     }
  //   } catch (e) {
  //     emit(AuthError(e.toString()));
  //     emit(UnAuthenticated());
  //   }
  // }

  Future<void> registerUser(String name, String email, String password) async {
    try {
      emit(AuthLoading());
      final user =
          await authRepo.signUpWithEmailAndPassword(email, password, name);

      if (user != null) {
        _currentUser = user;

        // ✅ Save user data in Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          "uid": user.uid,
          "name": name,
          "email": email,
          "createdAt": FieldValue.serverTimestamp(),
        });

        emit(Authenticated(user));
      } else {
        emit(UnAuthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(UnAuthenticated());
    }
  }

  // Logout user
  Future<void> logout() async {
    await authRepo.logout();
    _currentUser = null; // ✅ Clear currentUser on logout
    emit(UnAuthenticated());
  }
}
