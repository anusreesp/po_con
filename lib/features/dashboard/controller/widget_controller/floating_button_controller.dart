import 'package:flutter_riverpod/flutter_riverpod.dart';

final documentIdProvider = StateProvider<String>((ref) {
  return "";
});

final collectionNameProvider = StateProvider<String>((ref) {
  return '';
});

bool isChecked = false;
final isCheckedProvider = StateProvider<bool>((ref) {
  return isChecked;
});

final statusProvider = StateProvider.autoDispose<String>((ref) {
  return "";
});
