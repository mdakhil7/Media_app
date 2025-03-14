import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:socialmedia_app/features/auth/data/firebase_auth.dart';
import 'package:socialmedia_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:socialmedia_app/features/auth/presentation/pages/auth.dart';
import 'package:socialmedia_app/features/home/presentation/screens/home.dart';
import 'package:socialmedia_app/features/profile/data/firebase_profile_repo.dart';
import 'package:socialmedia_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:socialmedia_app/features/storage/data/firebase_storage_repo.dart';
import 'package:socialmedia_app/themes/light_theme.dart';

class MyApp extends StatelessWidget {
  final authRepo = FirebaseAuthRepo();
  final profileRepo = FirebaseProfileRepo();
  final storageRrepo = FirebaseStorageRepo();

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
            storageRepo: storageRrepo,
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkThemes, // Ensure correct theme usage
        home: ConnectivityWrapper(
          child: BlocConsumer<AuthCubit, AuthState>(
            builder: (context, authState) {
              if (authState is Authenticated) {
                return const HomeScreen();
              } else if (authState is UnAuthenticated) {
                return const AuthPage();
              } else {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
            },
            listener: (context, state) {
              if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class ConnectivityWrapper extends StatefulWidget {
  final Widget child;
  const ConnectivityWrapper({super.key, required this.child});

  @override
  _ConnectivityWrapperState createState() => _ConnectivityWrapperState();
}

class _ConnectivityWrapperState extends State<ConnectivityWrapper> {
  late Connectivity _connectivity;
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _connectivity = Connectivity();
    _checkConnectivity();

    _connectivity.onConnectivityChanged.listen((result) async {
      bool hasInternet = await _hasInternetAccess();
      if (hasInternet != _isConnected) {
        setState(() {
          _isConnected = hasInternet;
        });

        if (!_isConnected) {
          _showSnackBar('No Internet Connection', Colors.red);
        } else {
          _showSnackBar('Back Online!', Colors.green);
        }
      }
    });
  }

  Future<void> _checkConnectivity() async {
    bool hasInternet = await _hasInternetAccess();
    if (hasInternet != _isConnected) {
      setState(() {
        _isConnected = hasInternet;
      });

      if (!_isConnected) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showSnackBar('No Internet Connection', Colors.red);
        });
      }
    }
  }

  Future<bool> _hasInternetAccess() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Stack(
      children: [
        widget.child,
        if (!_isConnected)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.red,
              padding: const EdgeInsets.all(8.0),
              child: const Center(
                child: Text(
                  'No Internet Connection',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
      ],
    )));
  }
}
