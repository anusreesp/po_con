import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_concierge/exception_handling/controllers/connectivity_controller.dart';
import 'package:htp_concierge/exception_handling/no_internet_exception.dart';
import 'package:htp_concierge/features/auth/controllers/auth_controller.dart';
import 'package:htp_concierge/features/auth/presentation/screens/login_screen.dart';

import 'dashboard.dart';

class StartPage extends ConsumerWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.watch(authProvider);
    final connectivity = ref.watch(connectivityProvider);

    ref.listen(authProvider, (previous, next) {
      if (next is AuthErrorState) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(next.msg)));
      }
    });

    if (connectivity is ConnectivityNone) {
      return const NoInternetPage();
    }

    if (authController is AuthLoggedInState) {
      return const Dashboard();
    }

    return LoginScreen();
  }

  // Widget _loader() {
  //   return const Scaffold(
  //     body: Center(
  //       child: CircularProgressIndicator(),
  //     ),
  //   );
  // }
}
