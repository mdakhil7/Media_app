import 'package:flutter/material.dart';
import 'package:socialmedia_app/features/auth/presentation/pages/login.dart';
import 'package:socialmedia_app/features/auth/presentation/pages/signup.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLogin = true;

  void toggleScreen() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        child: showLogin
            ? LoginPage(toggles: toggleScreen, key: const ValueKey('login'))
            : RegisterPage(
                toggles: toggleScreen, key: const ValueKey('register')),
      ),
    );
  }
}
