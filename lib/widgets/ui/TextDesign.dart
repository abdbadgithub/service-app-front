import 'package:flutter/cupertino.dart';
import 'package:service_app/constants.dart' as constants;
class TextDesign extends StatelessWidget {
  final String text;
  final String type;

  const TextDesign({super.key, required this.text, required this.type});
  @override
  Widget build(BuildContext context) {
    if(type == "title")
      return
        Text(text, style: const TextStyle(
            fontSize: 12,
            fontFamily: 'aljazira',
            fontWeight: FontWeight.bold),
        );
     if(type == "text")
      return Text(text, style: const TextStyle(
      fontSize: 12,
      fontFamily: 'aljazira',
      color: constants.lightGrey,
          fontWeight: FontWeight.normal));
      return Placeholder();
  }
}
