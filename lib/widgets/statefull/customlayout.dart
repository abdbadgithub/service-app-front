import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:service_app/constants.dart' as constants;
import 'package:service_app/widgets/statefull/header.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'footer.dart';

class CustomLayout extends StatefulWidget {
  final Widget? child;

  const CustomLayout({Key? key, this.child}) : super(key: key);

  @override
  State<CustomLayout> createState() => _CustomLayout();
}

class _CustomLayout extends State<CustomLayout> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("en", "US"),
        Locale("ar", "AE"),
      ],
      title: 'Fetch Data Example',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _controller,
                        minLines: 6,
                        maxLines: 12,
                        textDirection: TextDirection.rtl,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          print('object');
                          setState(() {
                            _controller.text = '';
                          });
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          int idKhedmet = prefs.getInt('idKhedmet') ?? 0;
                          String? accessToken = prefs.getString('access_token');
                          print('Retrieved idKhedmet: $idKhedmet');

                          String url = '${constants.api}/notes';

                          try {
                            String jsonBody = jsonEncode({
                              "Khadamet_Notes": _controller.text,
                            });

                            http.Response response = await http.post(
                              Uri.parse(url),
                              headers: {
                                'Authorization': 'Bearer $accessToken',
                                'Content-Type': 'application/json',
                              },
                              body: jsonBody,
                            );

                            if (response.statusCode == 201) {
                              print('HTTP Request successful');
                              print('Response data: ${response.body}');
                            } else {
                              print(
                                  'HTTP Request failed with status code: ${response.statusCode}');
                            }
                          } catch (error) {
                            print('Error during HTTP Request: $error');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD9D9D9),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: GestureDetector(
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(width: 8),
                              Text(
                                'إضافة ملاحظة',
                                style: TextStyle(
                                    color: constants.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'aljazira'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          backgroundColor: constants.primaryColor,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(100))),
          child: SvgPicture.asset("assets/icons/add.svg"),
        ),
        body: Localizations.override(
          context: context,
          locale: const Locale('ar'),
          child: Builder(
            builder: (context) {
              if (widget.child != null) {
                return Column(
                  children: <Widget>[
                    const Header(),
                    Expanded(
                      child: SingleChildScrollView(
                        child: widget.child!,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width * 0.9,
                      margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: <Widget>[
                    const Header(),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width * 0.9,
                      margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    ),
                  ],
                );
              }
            },
          ),
        ),
        bottomNavigationBar: Localizations.override(
          context: context,
          locale: const Locale('ar'),
          child: const Footer(),
        ),
      ),
    );
  }
}
