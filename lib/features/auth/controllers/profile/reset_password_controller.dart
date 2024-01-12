import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/services/fire_auth_service.dart';

final resetPasswordProvider =
    StateNotifierProvider<ResetPasswordController, ResetPasswordState>((ref) {
  final fire = ref.watch(firebaseAuthServiceProvider);
  return ResetPasswordController(fire);
});

class ResetPasswordController extends StateNotifier<ResetPasswordState> {
  final FirebaseAuthenticate _fire;
  ResetPasswordController(this._fire) : super(ResetPasswordInitialState());

  updatePassword(String currentPassword, String newPassword) async {
    try {
      state = ResetPasswordLoading();
      await _fire.updatePassword(currentPassword, newPassword);

      state = ResetPasswordDoneState();
    } catch (e) {
      state = ResetPasswordErrorState(e.toString());
    }
  }
}

abstract class ResetPasswordState {}

class ResetPasswordInitialState extends ResetPasswordState {}

class ResetPasswordLoading extends ResetPasswordState {}

class ResetPasswordDoneState extends ResetPasswordState {}

class ResetPasswordErrorState extends ResetPasswordState {
  final String msg;
  ResetPasswordErrorState(this.msg);
}
