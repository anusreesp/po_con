import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freshchat_sdk/freshchat_sdk.dart';
import 'package:freshchat_sdk/freshchat_user.dart';

import '../../../auth/data/services/fcm_services.dart';
import '../../../auth/data/services/fire_auth_service.dart';

final freshChatProvider = Provider.autoDispose<FreshChatController>((ref) {
  // final profile = ref.watch(profileControllerProvider);
  final auth = ref.watch(firebaseAuthServiceProvider);
  final fcm = ref.watch(fcmServiceProvider);
  // if (profile is ProfileLoaded) {
  //   return FreshChatController(profile, auth, fcm);
  // }
  return FreshChatController(auth, fcm);
});

class FreshChatController {
  // final ProfileLoaded? _profile;
  final FirebaseAuthenticate _auth;
  final FCMServices _fcm;
  FreshChatController(
      // this._profile,
      this._auth,
      this._fcm) {
    initialize();
  }

  initialize() async {
    Freshchat.init(
      '83dad3b7-2238-4a06-9352-1cb4a7844e90',
      '5d8b5435-66c7-4670-9668-884c1455b0b1',
      'msdk.in.freshchat.com',
    );

    Freshchat.identifyUser(externalId: _auth.uid);

    FreshchatUser user = await Freshchat.getUser;
    // if (_profile != null) {
    //   user.setFirstName(_profile!.profileData.name);
    Freshchat.setUser(user);
    // }

    // setNotificationToken();
  }

  startChat() {
    Freshchat.showConversations();
  }

  setNotificationToken() async {
    final fcmToken = await _fcm.getToken();
    if (fcmToken != null) {
      Freshchat.setPushRegistrationToken(fcmToken);
    }
  }
}
