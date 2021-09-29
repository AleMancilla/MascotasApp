import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mascotas_app/business/google_sign_in.dart';
import 'package:mascotas_app/pages/home_page.dart';
import 'package:mascotas_app/utils/navigator_route.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CupertinoButton(
          onPressed: () {
            signInWithGoogle()
                .then((value) =>
                    navigatorPushReplacement(context, const HomePage()))
                // ignore: avoid_print
                .onError((error, stackTrace) => print('ERROR DE SIGNOT'));
          },
          child: const Text('SignIn with google'),
        ),
      ),
    );
  }
}
