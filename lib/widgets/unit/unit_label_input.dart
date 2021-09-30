import 'package:flutter/material.dart';

class UnitLabelInput extends StatefulWidget {
  final String title;
  final TextEditingController control;
  final bool descrip;
  final String? helptext;
  final bool isNumber;

  const UnitLabelInput(
      {Key? key,
      required this.title,
      required this.control,
      this.descrip = false,
      this.helptext,
      this.isNumber = false})
      : super(key: key);

  @override
  State<UnitLabelInput> createState() => _UnitLabelInputState();
}

class _UnitLabelInputState extends State<UnitLabelInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
      margin: const EdgeInsets.only(bottom: 10, top: 10),
      width: double.infinity,
      child: Row(
        children: [
          // Text("$title:"),
          Expanded(
            child: TextField(
              minLines: (widget.descrip) ? 3 : 1,
              maxLines: (widget.descrip) ? 10 : 1,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: widget.title,
                helperText: widget.helptext,
              ),
              keyboardType:
                  widget.isNumber ? TextInputType.phone : TextInputType.text,
              controller: widget.control,
              onChanged: (value) {
                setState(() {});
              },
              // onChanged: (n) {
              //   print("completo########");
              //   if(!ordenData.flagEdit){ordenData.flagEdit = true;}
              // },
            ),
          )
        ],
      ),
    );
  }
}
