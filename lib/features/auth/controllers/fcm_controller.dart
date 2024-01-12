import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/dynamic_routes.dart';
import '../data/services/fcm_services.dart';

final fcmProvider = StateNotifierProvider((ref) {
  final fcm = ref.watch(fcmServiceProvider);
  return FCMController(fcm, ref);
});

@pragma('vm:entry-point')
Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(
      "Handling a background message: ${message.notification?.title} : ${message.notification?.body}");
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
// ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
// ignore: avoid_print
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}

class FCMController extends StateNotifier<FCMStates> {
  final FCMServices _fcm;
  final Ref _ref;
  FCMController(this._fcm, this._ref) : super(FCMInitial()) {
    init();
    _initLocalNotification();
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  init() async {
    print("FIREBASE INITIALIZATION");
    try {
      final authorized = await _fcm.registerNotification();
      if (authorized) {
        RemoteMessage? initialMessage = await _fcm.getInitialMessage();
        if (initialMessage != null) {
          _handleInitialMessage(initialMessage);
        }

        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
          print(
              "onMessage: ${message.notification?.title} : ${message.notification?.body} ${message.messageId}");
          print("NOTIFICATION DATA: ${message.data}");

          _showNotificationWithSound(0, message.notification?.title,
              message.notification?.body, message.data['url']);
        });

// FirebaseMessaging.onBackgroundMessage((_firebaseMessagingBackgroundHandler));

        FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
          print(
              "onMessageOpenedApp: ${message.notification?.title} : ${message.notification?.body} ${message.messageId}");
          print("NOTIFICATION DATA OPENED: ${message.data}");

//{internal_redirect: true, body: , title: Get ready to party like it's 1999 - your entry to Jacob Munoz is confirmed !, url: event_entry_bookings/135582c8-5272-40b7-9169-32b752cf9671}
//Handle message click here
          redirect(message.data, _ref);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void _handleInitialMessage(RemoteMessage message) {
    print(
        "onInitialMessage: ${message.notification?.title} : ${message.notification?.body} ${message.messageId}");
  }

  _initLocalNotification() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
        onDidReceiveNotificationResponse: onSelectNotification);
  }

  onSelectNotification(NotificationResponse notification) async {
    print("LOCAL NOTIFICATION CLICKED");
    print(notification.payload);
    redirect({'url': notification.payload}, _ref);
  }

  Future _showNotificationWithSound(
      int id, String? title, String? body, String? payload) async {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name',
        importance: Importance.max, priority: Priority.high);

    const iOSPlatformChannelSpecifics = DarwinNotificationDetails();

    const platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }
}

abstract class FCMStates {}

class FCMInitial extends FCMStates {}
