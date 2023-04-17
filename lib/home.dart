import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'screens/auth_screen.dart';
import 'screens/chat_screen.dart';

class Home extends StatelessWidget{

final FirebaseAuth _auth = FirebaseAuth.instance;

@override
Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Chat app',
    theme: ThemeData(
        primarySwatch: Colors.purple,
        backgroundColor: Colors.purple,
        accentColor: Colors.amber,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.amber,
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)))),
    home:
    StreamBuilder(
      stream: _auth.authStateChanges(),
      builder: (ctx, userSnapShot) {
        if (userSnapShot.hasData) {
          return ChatScreen();
        }
        return AuthScreen();
      },
    ),
  );
}}
