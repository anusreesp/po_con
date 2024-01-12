import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DashboardTab { home, upcoming, past }

final dashboardPageIndexProvider =
    StateProvider<DashboardTab>((ref) => DashboardTab.home);
