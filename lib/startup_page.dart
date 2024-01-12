// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:htp_concierge/features/auth/presentation/screens/login_screen.dart';
// import 'package:htp_concierge/global_providers.dart';

// import 'dashboard.dart';

// class StartupPage extends ConsumerWidget {
//   const StartupPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final authStateChanges = ref.watch(authStateChangeProvider);
//     return authStateChanges.when(data: (user) {
//       if (user != null) {
//         debugPrint(user.email);
//         return const Dashboard();
//         // return LoginPage();
//       } else {
//         // return SplashScreenPage();
//         return LoginScreen();
//       }
//     }, error: (error, _) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text(error.toString())));
//       return LoginScreen();
//     }, loading: () {
//       return _loader();
//     });
//   }

//   Widget _loader() {
//     return const Scaffold(
//       body: Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }
