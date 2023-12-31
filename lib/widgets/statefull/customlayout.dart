import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:service_app/widgets/statefull/header.dart';
import 'package:service_app/constants.dart' as constants;
import 'footer.dart';

class CustomLayout extends StatefulWidget {
  final Widget? child;

  const CustomLayout({super.key, this.child});

  @override
  State<CustomLayout> createState() => _CustomLayout();
}

class _CustomLayout extends State<CustomLayout> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: const [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale("en", "US"),
          Locale("ar", "AE"), // OR Locale('ar', 'AE') OR Other RTL locales
        ],
        title: 'Fetch Data Example',
        theme: ThemeData(
          // Use the custom color as the primary swatch
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          body: Column(children: <Widget>[
            const Header(),
            if (widget.child != null)
              Expanded(child: SingleChildScrollView(child:widget.child!)),
            Align(
                alignment: Alignment.centerLeft,
                child: FloatingActionButton(
                    onPressed: () {
                      // Add your onPressed code here!
                    },
                    backgroundColor: constants.primaryColor,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    child: SvgPicture.asset("assets/icons/add.svg"))),
          ]),
          bottomNavigationBar: const Footer(),
        ));
  }
}
