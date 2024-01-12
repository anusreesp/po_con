import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app_config.dart';
import 'firebase_options.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'test',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // FirebaseMessaging messaging = FirebaseMessaging.instance;

  // NotificationSettings settings = await messaging.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );

  const configuration = AppConfig(
      environment: AppEnvironment.prod,
      baseUrl: 'https://partyone-live-pro-1.as.r.appspot.com');
  final container = ProviderContainer(
      overrides: [
        appConfigProvider.overrideWithValue(configuration)
      ]
  );

  runApp(const ProviderScope(child: MyApp()));
}
