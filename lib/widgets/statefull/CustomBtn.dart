import 'package:flutter/material.dart';

class CustomBtn extends StatefulWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const CustomBtn(
      {super.key, required this.buttonText, required this.onPressed});

  @override
  State<CustomBtn> createState() => _CustomBtnState();
}

class _CustomBtnState extends State<CustomBtn> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: widget.onPressed, child: Text(widget.buttonText));
  }
}
