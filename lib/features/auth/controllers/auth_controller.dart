import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_concierge/features/auth/data/services/fire_auth_service.dart';

final authProvider = StateNotifierProvider<AuthController, AuthState>((ref) {
  final authService = ref.watch(firebaseAuthServiceProvider);
  return AuthController(authService);
});

class AuthController extends StateNotifier<AuthState> {
  final FirebaseAuthenticate _service;
  AuthController(this._service) : super(AuthInitialState()) {
    checkUser();
  }

  Future<void> checkUser() async {
    state = AuthLoadingState();
    try {
      final user = _service.geCurrentUser();

      if (user != null) {
        state = AuthLoggedInState(user);
      } else {
        state = AuthInitialState();
      }
    } catch (e) {
      state = AuthErrorState("This account have no access");
    }
  }

  userLogin(String email, String password) async {
    try {
      state = AuthLoadingState();
      final credential = await _service.loginUsingEmailAndPassword(
          email: email, password: password);
      if (credential != null) {
        checkUser();
      } else {
        state = AuthErrorState("This account have no access");
        await FirebaseAuth.instance.signOut();
        state = AuthInitialState();
      }

      return credential;
    } catch (e) {
      if (e.toString() ==
          "NoSuchMethodError: The method '[]' was called on null.\nReceiver: null\nTried calling: [](0)") {
        state = AuthErrorState("This account have no access");
        await FirebaseAuth.instance.signOut();
      } else if (e.toString() ==
          "type 'Null' is not a subtype of type 'String'") {
        throw ('This account have no access');
      } else {
        state = AuthErrorState(e.toString());
      }
    }
  }
}

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthLoggedInState extends AuthState {
  final User user;
  AuthLoggedInState(this.user);
}

class AuthErrorState extends AuthState {
  final String msg;
  AuthErrorState(this.msg);
}
