import 'dart:io';

import 'package:chat_app/widgets/auth/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(String username, String password, String email,
      File image, bool isLogin, BuildContext ctx) async {
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child((authResult.user?.uid).toString() + '.jpg');
        await ref.putFile(image);

        final url = ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user?.uid)
            .set({
          'uname': username, 'email': email,
          // 'imageUrl': url,
        });
      }
    } on PlatformException catch (error) {
      var message = "An error occurred, please check your credentials";
      if (error.message != null) {
        message = error.message!;
      }
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text("$error"),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      print(error);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: AuthForm(_submitAuthForm, _isLoading));
  }
}
