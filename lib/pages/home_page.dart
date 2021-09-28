import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mascotas_app/business/google_sign_in.dart';
import 'package:mascotas_app/pages/login/sign_in.dart';
import 'package:mascotas_app/utils/navigator_route.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
      ),
      body: Column(
        children: [
          const Text('Hello World'),
          CupertinoButton(
            onPressed: () {
              signOutWithGoogleAndFirebase()
                  .then((value) =>
                      navigatorPushReplacement(context, const SignInPage()))
                  .onError((error, stackTrace) => print('ERROR DE SIGNOT'));
            },
            child: const Text('Sign out'),
          )
        ],
      ),
    );
  }
}
