import 'package:flutter/material.dart';

void navigatorPushReplacement(BuildContext context, Widget page) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute<void>(
      builder: (BuildContext context) => page,
    ),
  );
}
