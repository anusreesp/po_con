import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fcmServiceProvider = Provider((ref) => FCMServices());

class FCMServices {
  final _fcm = FirebaseMessaging.instance;

  Future<String?> getToken() async {
    return await _fcm.getToken();
  }

  Future<bool> registerNotification() async {
    NotificationSettings settings = await _fcm.requestPermission(
        alert: true, badge: true, provisional: true, sound: true);

    debugPrint("${settings.authorizationStatus}");

    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      debugPrint('User granted permission for notification');
      return true;
    } else {
      debugPrint(
          'User declined or has not accepted permission for notification');
      return false;
    }
  }

  Future<RemoteMessage?> getInitialMessage() async {
    return await _fcm.getInitialMessage();
  }

  sendMessage() async {
// final message = Message
    await _fcm.sendMessage(data: {}, messageId: '1234567');
  }
}
