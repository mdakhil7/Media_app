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
      apiKey: 'AIzaSyBe7x4cks2_-NAL_VIMJGVHdJy6M6YwVLI',
      appId: '1:1072842137623:android:2de8693e98535dc332fc52',
      messagingSenderId: '1072842137623',
      projectId: 'foodapp-49d1a',
      // apiKey: 'AIzaSyCVgHUYPWHMXrX4Lr2oLiQIJjK20wZirmc',
      // appId: '1:577450694380:android:2343eb1e771850d9ba77c9',
      // messagingSenderId: '577450694380',
      // projectId: 'media-fd362',
    ),
  );
  runApp(
    MyApp(),
  );
}


//this are comments for pushing code 
// git checkout -b posting
// to check the branch git branch
// git add .
// git commit -m "Added new feature in posting branch"
// git push origin posting
