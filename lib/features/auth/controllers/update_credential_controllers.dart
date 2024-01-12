import 'package:flutter_riverpod/flutter_riverpod.dart';

final editEmailProvider = StateProvider<bool>((ref) => false);

final updateEmailProvider = StateProvider<String>((ref) {
  return "";
});

final editPasswordProvider = StateProvider<bool>((ref) => false);

final currentPasswordProvider = StateProvider<String>((ref) {
  return "";
});

final newPasswordProvider = StateProvider<String>((ref) {
  return "";
});

final confirmPasswordProvider = StateProvider<String>((ref) {
  return "";
});

final claimsClubIdProvider = StateProvider<String>((ref) {
  return "";
});
