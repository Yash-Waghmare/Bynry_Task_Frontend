import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final String text;
  final IconData prefixIcon;
  final bool isSuffix;
  final IconData suffixIcon;
  late bool isPasswordType;
  final TextEditingController controller;
  TextFieldWidget({
    super.key,
    required this.text,
    required this.prefixIcon,
    required this.isSuffix,
    required this.suffixIcon,
    required this.isPasswordType,
    required this.controller,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: widget.controller,
        obscureText: widget.isPasswordType,
        autocorrect: !widget.isPasswordType,
        cursorColor: Colors.grey,
        style: TextStyle(
          color: Color.fromARGB(255, 39, 23, 159),
        ),
        decoration: InputDecoration(
            focusColor: Colors.grey,
            prefixIcon: Icon(
              widget.prefixIcon,
              color: Color.fromARGB(255, 39, 23, 159),
            ),
            suffixIcon: widget.isSuffix
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        widget.isPasswordType = !widget.isPasswordType;
                      });
                    },
                    icon: widget.isPasswordType
                        ? Icon(
                            widget.suffixIcon,
                            color: Color.fromARGB(255, 39, 23, 159),
                          )
                        : Icon(
                            CupertinoIcons.eye_slash_fill,
                            color: Colors.grey,
                          ),
                  )
                : SizedBox(),
            labelText: widget.text,
            labelStyle: TextStyle(
              color: Color.fromARGB(255, 39, 23, 159),
            ),
            filled: true,
            // floatingLabelBehavior: FloatingLabelBehavior.never,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide:
                    const BorderSide(width: 0, style: BorderStyle.none)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 39, 23, 159)),
              borderRadius: BorderRadius.circular(10.0),
            )),
        keyboardType: widget.isPasswordType
            ? TextInputType.visiblePassword
            : TextInputType.emailAddress);
  }
}
