import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mascotas_app/pages/home_page.dart';
import 'package:mascotas_app/pages/login/sign_in.dart';
import 'package:mascotas_app/utils/navigator_route.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    verifyStatusUserLogin();
    super.initState();
  }

  void redirectorToPage(Widget page) {
    Future.delayed(Duration.zero, () {
      Timer(const Duration(seconds: 4), () {
        try {
          navigatorPushReplacement(context, page);
        } catch (e) {
          throw 'NO CONTEXT IN PAGE';
        }
      });
    });
  }

  void verifyStatusUserLogin() {
    try {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          redirectorToPage(const SignInPage());
        } else {
          redirectorToPage(const HomePage());
        }
      });
    } catch (e) {
      throw 'error de estado';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.blueGrey[900],
        child: Image.asset(
          'assets/pet_icon.jpg',
          fit: BoxFit.cover,
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}
