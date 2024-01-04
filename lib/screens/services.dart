import 'package:flutter/material.dart';
import 'package:service_app/widgets/statefull/CustomBtn.dart';

class Services extends StatefulWidget {
  const Services({super.key});

  @override
  State<Services> createState() => _ServiceState();
}

class _ServiceState extends State<Services> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Center(
          child: CustomBtn(
        onPressed: () {
          Navigator.pop(context);
        },
        buttonText: "TextButton",
      )),
    );
  }
}
