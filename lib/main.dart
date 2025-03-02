import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socialmedia_app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Lock the app to portrait mode
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyCVgHUYPWHMXrX4Lr2oLiQIJjK20wZirmc',
      appId: '1:577450694380:android:2343eb1e771850d9ba77c9',
      messagingSenderId: '577450694380',
      projectId: 'media-fd362',
    ),
  );
  runApp(
    MyApp(),
  );
}
