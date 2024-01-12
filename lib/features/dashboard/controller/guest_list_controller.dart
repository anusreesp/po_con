import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

final upcomingSelectedDateProvider = StateProvider.autoDispose<DateTime>(
    (ref) => DateTime.now().add(const Duration(days: 1)));

final postSelectedDateProvider = StateProvider.autoDispose<DateTime>(
    (ref) => DateTime.now().subtract(const Duration(days: 1)));

// class SelectedDate {
//   DateTime onSelectdate;
//   SelectedDate(this.onSelectdate);
// }
