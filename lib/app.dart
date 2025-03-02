import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia_app/features/auth/data/firebase_auth.dart';
import 'package:socialmedia_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:socialmedia_app/features/auth/presentation/pages/auth.dart';
import 'package:socialmedia_app/features/home/presentation/screens/home.dart';
import 'package:socialmedia_app/features/profile/data/firebase_profile_repo.dart';
import 'package:socialmedia_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:socialmedia_app/themes/light_theme.dart';

class MyApp extends StatelessWidget {
  final authRepo = FirebaseAuthRepo();

  final profileRepo = FirebaseProfileRepo();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AuthCubit(authRepo: authRepo)..checkAuth()),
        BlocProvider(
          create: (context) => ProfileCubit(
            profileRepo: profileRepo,
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkThemes, // Applying the theme
        home: BlocConsumer<AuthCubit, AuthState>(
          builder: (context, authState) {
            if (authState is Authenticated) {
              return const HomeScreen();
            } else if (authState is UnAuthenticated) {
              return const AuthPage();
            } else {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
