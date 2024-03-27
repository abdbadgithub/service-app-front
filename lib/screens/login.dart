import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:service_app/constants.dart' as constants;
import 'package:service_app/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/img/doubleCircle.png',
                  fit: BoxFit.cover,
                ),
              ),
              const Positioned(
                top: 125,
                right: 20,
                child: Text(
                  'تسجيل الدخول',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'aljazira'),
                ),
              ),
            ],
          ),
          const LoginForm(),
        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    String url = "https://service-app.abdallahbadra.com/auth/login";

    Map<String, String> requestBody = {
      'UserName': _usernameController.text,
      'Password': _passwordController.text,
    };

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        print("Login successful!");
        print("Response data: ${response.body}");

        Map<String, dynamic> responseBody = jsonDecode(response.body);

        String? accessToken = responseBody['access_token'];

        if (accessToken != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('access_token', accessToken);
        }

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SplashScreen()),
        );
      } else {
        // ignore: use_build_context_synchronously
        AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.rightSlide,
          autoHide: const Duration(seconds: 1),
          desc: 'إسم المستخدم أو كلمة السر خطأ',
        ).show();
        print("Login failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error occurred: $e");
    }

    _usernameController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'اسم المستخدم',
              style: TextStyle(
                color: constants.primaryColor,
                fontSize: 17,
                fontWeight: FontWeight.bold,
                fontFamily: 'aljazira',
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
              ),
              child: TextField(
                controller: _usernameController,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                        color: constants.primaryColor, width: 0.1),
                  ),
                  filled: true,
                  labelStyle: const TextStyle(
                    color: constants.primaryColor,
                    fontFamily: 'aljazira',
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'كلمة السر',
              style: TextStyle(
                color: constants.primaryColor,
                fontSize: 17,
                fontWeight: FontWeight.bold,
                fontFamily: 'aljazira',
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
              ),
              child: TextField(
                obscureText: true,
                controller: _passwordController,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                        color: constants.primaryColor, width: 0.1),
                  ),
                  filled: true,
                  labelStyle: const TextStyle(
                    color: constants.primaryColor,
                    fontFamily: 'aljazira',
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              height: 60,
              width: MediaQuery.of(context).size.width * 0.9,
              child: ElevatedButton(
                onPressed: () {
                  _login(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: constants.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text(
                  'تسجيل الدخول',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'aljazira',
                      color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
