import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/auth/controllers/fcm_controller.dart';
import 'features/dashboard/controller/dashboard_page_index.dart';
import 'features/dashboard/presentation/screens/home_screen.dart';
import 'features/dashboard/presentation/screens/past_guest_list.dart';
import 'features/dashboard/presentation/screens/upcoming_guest_list.dart';
import 'features/dashboard/presentation/widgets/floating_buttons.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(fcmProvider);
    final controller = ref.watch(dashboardPageIndexProvider);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        extendBody: true,
        body: IndexedStack(
          index: controller.index,
          children: const [HomeScreen(), UpcomingGuestList(), PastGuestList()],
        ),
        floatingActionButton: const FloatingButtons(),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
      ),
    );
  }
}
