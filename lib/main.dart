import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:chat_app/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: AnimatedSplashScreen(
      splash: const Icon(Icons.home),
      duration: 3000,
      splashTransition: SplashTransition.scaleTransition,
      backgroundColor: Colors.amber,
      nextScreen: Home(),
    ));
  }
}
