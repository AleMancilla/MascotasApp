import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mascotas_app/pages/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Timer(const Duration(seconds: 4), () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const HomePage(),
            ));
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.blueGrey[900],
        child: Image.asset(
          'assets/pet_icon.jpg',
          fit: BoxFit.cover,
          width: size.width / 2,
          height: size.height / 2,
        ),
      ),
    );
  }
}
