import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/auth/data/services/fire_auth_service.dart';

final authStateChangeProvider = StreamProvider<User?>(
    (ref) => ref.watch(firebaseAuthServiceProvider).authStateChanges());

final updatePasswordProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthServiceProvider).authStateChanges();
});
