import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:socialmedia_app/features/auth/domain/entites/user_app.dart';
import 'package:socialmedia_app/features/auth/domain/repo/user_auth.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AppUser? _currentUser;
  AuthCubit({
    required this.authRepo,
  }) : super(AuthInitial());

  //creating function

  void checkAuth() async {
    final AppUser? user = await authRepo.getCurrentUser();

    if (user != null) {
      _currentUser = user;
      emit(Authenticated(user));
    } else {
      emit(UnAuthenticated());
    }
  }

  //get the current user
  AppUser? get currentUser => _currentUser;

  //user login
  Future<void> loginUser(String email, String password) async {
    try {
      emit(AuthLoading());
      final user = await authRepo.loginWithEmailAndPassword(email, password);

      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(UnAuthenticated());
      }
    } catch (e) {
      emit(
        AuthError(
          e.toString(),
        ),
      );
      emit(UnAuthenticated());
    }
  }

  //creating new user
  Future<void> registerUser(String name, String email, String password) async {
    try {
      emit(AuthLoading());
      final user = await authRepo.signUpWithEmailAndPassword(
        email,
        password,
        name,
      );

      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(UnAuthenticated());
      }
    } catch (e) {
      emit(
        AuthError(
          e.toString(),
        ),
      );
      emit(UnAuthenticated());
    }
  }

  //logout
  Future<void> logout() async {
    authRepo.logout();
    emit(UnAuthenticated());
  }
}
