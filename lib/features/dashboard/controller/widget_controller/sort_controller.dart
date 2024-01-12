import 'package:flutter_riverpod/flutter_riverpod.dart';

// enum Membership { All, Solitaire, Platinum, Gold, Silver, Amethyst }

// final sortListProvider = StateProvider<membership>((ref) {
//   return membership.All;
// });

final sortProvider = StateProvider<String>((ref) {
  return "";
});

List<String> membershipsId = [];
final membershipSortProvider = StateProvider<List<String>>((ref) {
  return membershipsId;
});
