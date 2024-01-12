import 'dart:async';
import 'package:flutter/material.dart';
import 'package:htp_concierge/features/auth/presentation/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _goNext();
  }

  _goNext() {
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //padding: EdgeInsets.only(top: 200,left: 115,bottom: 113),

        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(color: Color(0xff171717)),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 80.0,
            ),
            const Image(
              image: AssetImage('assets/images/logo.png'),
              height: 270,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.40,
            ),
            const Text(
              'CONCIERGE APP',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
