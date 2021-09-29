import 'package:flutter/material.dart';

class BottomNavigatorIcon extends StatefulWidget {
  final String? textIcon;
  final IconData? icono;
  // final // Function(int)? onTap;
  final Function()? onTap;
  final bool isSelect;

  const BottomNavigatorIcon(
      {Key? key, this.textIcon, this.icono, this.onTap, this.isSelect = false})
      : super(key: key);

  @override
  State<BottomNavigatorIcon> createState() => _BottomNavigatorIconState();
}

class _BottomNavigatorIconState extends State<BottomNavigatorIcon> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap!();
      },
      child: Column(
        children: [
          Icon(
            widget.icono,
            color: widget.isSelect ? Colors.green : Colors.grey,
          ),
          Text(
            widget.textIcon.toString(),
            style: TextStyle(
              color: widget.isSelect ? Colors.green : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
