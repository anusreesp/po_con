import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_concierge/features/auth/controllers/auth_controller.dart';
part 'connectivity_states.dart';

// final connectivityProvider = StreamProvider<ConnectivityResult>((ref) => Connectivity().onConnectivityChanged);
final connectivityProvider = StateNotifierProvider((ref) {
  return ConnectivityController(Connectivity(), ref);
});

class ConnectivityController extends StateNotifier<ConnectivityState> {
  final Connectivity _connectivity;
  final Ref _ref;
  ConnectivityController(this._connectivity, this._ref)
      : super(ConnectivityLoading()) {
    init();
  }

  late StreamSubscription<ConnectivityResult> subscription;
  late ConnectivityResult lastConnectionStatus;

  init() async {
    state = ConnectivityLoading();
    lastConnectionStatus = await _connectivity.checkConnectivity();
    if (lastConnectionStatus == ConnectivityResult.none) {
      state = ConnectivityNone();
    } else {
      state = ConnectivityLoaded();
    }
    subscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        state = ConnectivityNone();
      } else {
        if (lastConnectionStatus == ConnectivityResult.none) {
          _ref.read(authProvider.notifier).checkUser();
        }
        state = ConnectivityLoaded();
      }
      lastConnectionStatus = result;
    });
  }
}
