import 'package:flutter/material.dart';
import 'package:htp_concierge/start_page.dart';

import 'app_theme.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // color: Colors.purple,
      theme: AppTheme.dark(),
      debugShowCheckedModeBanner: false,
      // home: StartupPage(),
      home: const StartPage(),
      // home: SplashScreen(),
      //home: Dashboard(),
    );
  }
}
