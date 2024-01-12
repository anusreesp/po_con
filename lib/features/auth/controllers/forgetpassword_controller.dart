import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/services/fire_auth_service.dart';

final forgetPasswordProvider =
    StateNotifierProvider<ForgetPasswordController, ForgetPasswordState>((ref) {
  final fire = ref.watch(firebaseAuthServiceProvider);
  return ForgetPasswordController(fire);
});

class ForgetPasswordController extends StateNotifier<ForgetPasswordState> {
  final FirebaseAuthenticate _fire;
  ForgetPasswordController(this._fire) : super(ForgetPasswordInitialState());

  sentEmailResetLink(String email) async {
    try {
      state = ForgetLoading();
      await _fire.resetPasswordEmail(email);

      state = ForgetPasswordLinkSentState();
    } catch (e) {
      state = ForgetPasswordErrorState(e.toString());
    }
  }
}

abstract class ForgetPasswordState {}

class ForgetPasswordInitialState extends ForgetPasswordState {}

class ForgetLoading extends ForgetPasswordState {}

class ForgetPasswordLinkSentState extends ForgetPasswordState {}

class ForgetPasswordErrorState extends ForgetPasswordState {
  final String msg;
  ForgetPasswordErrorState(this.msg);
}
