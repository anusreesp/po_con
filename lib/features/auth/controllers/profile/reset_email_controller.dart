import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/services/fire_auth_service.dart';

final resetEmailProvider =
    StateNotifierProvider<ResetEmailController, ResetEmailState>((ref) {
  final fire = ref.watch(firebaseAuthServiceProvider);
  return ResetEmailController(fire);
});

class ResetEmailController extends StateNotifier<ResetEmailState> {
  final FirebaseAuthenticate _fire;
  ResetEmailController(this._fire) : super(ResetEmailInitialState());

  updateEmail(String email) async {
    try {
      state = ResetEmailLoading();
      await _fire.updateEmail(email);

      state = ResetEmailLinkSentState();
    } catch (e) {
      state = ResetEmailErrorState(e.toString());
    }
  }
}

abstract class ResetEmailState {}

class ResetEmailInitialState extends ResetEmailState {}

class ResetEmailLoading extends ResetEmailState {}

class ResetEmailLinkSentState extends ResetEmailState {}

class ResetEmailErrorState extends ResetEmailState {
  final String msg;
  ResetEmailErrorState(this.msg);
}
