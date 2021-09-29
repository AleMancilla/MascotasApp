import 'package:flutter/material.dart';

class BottomNavigatorBar extends StatelessWidget {
  final List<Widget> listIconBytton;

  const BottomNavigatorBar({Key? key, required this.listIconBytton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
          listIconBytton.map((dataIcon) => Expanded(child: dataIcon)).toList(),
    );
  }
}
