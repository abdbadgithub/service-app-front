import 'package:flutter/material.dart';
import 'package:service_app/constants.dart' as constants;
import 'package:service_app/screens/splash_screen.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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

  void _login() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SplashScreen()),
    );
    String username = _usernameController.text;
    String password = _passwordController.text;

    print('Username: $username');
    print('Password: $password');

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
            Container(
              margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              height: 60,
              width: MediaQuery.of(context).size.width * 0.9,
              child: ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: constants.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text(
                  'تسجيل الدخول',
                  style: TextStyle(fontSize: 20.0, fontFamily: 'aljazira'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
