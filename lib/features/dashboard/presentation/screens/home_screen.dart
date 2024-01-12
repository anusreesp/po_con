import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_concierge/features/dashboard/data/models/club_booking_list.dart';
import 'package:htp_concierge/features/auth/presentation/screens/update_profile.dart';
import 'package:htp_concierge/features/auth/presentation/widgets/custom_search_box.dart';
import 'package:htp_concierge/features/dashboard/controller/widget_controller/search_controller.dart';
import 'package:htp_concierge/features/dashboard/controller/widget_controller/tab_controller.dart';
import 'package:htp_concierge/features/auth/presentation/widgets/custom_material_button.dart';
import 'package:htp_concierge/features/dashboard/presentation/widgets/qr_scanner.dart';
import 'package:htp_concierge/features/dashboard/presentation/widgets/sort_list.dart';
import '../../../../exception_handling/no_bookings_exception.dart';
import '../../../auth/presentation/widgets/custom_text_button.dart';
import '../../controller/home/home_lists_controller.dart';
import '../widgets/guest_card.dart';
import '../widgets/profile_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tController = ref.watch(tabController);
    final homeSearchController = ref.watch(homeControllerProvider);
    final search = ref.watch(nameSearchProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.read(homeListProvider.notifier).getGuests();
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xff171717),
          extendBody: true,
          extendBodyBehindAppBar: true,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20.0, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileCard(
                    child: GestureDetector(
                      onTap: () async {
                        homeSearchController.clear();
                        ref.read(nameSearchProvider.notifier).state = '';
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UpdateProfile()));
                      },
                      child: CircleAvatar(
                        radius: 17,
                        backgroundColor: Colors.black.withOpacity(0.4),
                        child: const Icon(
                          Icons.settings_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  const Padding(padding: EdgeInsets.only(left: 25.0)),
                  const Text(
                    '   Guests for Today',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xffFFFFFF),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const CustomSearchBox(
                    page: 'home',
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomTextButton(
                              onTap: () {
                                ref.read(tabController.notifier).state =
                                    GuestTab.all;
                              },
                              text: 'All',
                              selected: tController == GuestTab.all),
                          CustomTextButton(
                              onTap: () {
                                ref.read(tabController.notifier).state =
                                    GuestTab.checkedIn;
                              },
                              text: 'Checked-in',
                              selected: tController == GuestTab.checkedIn),
                          CustomTextButton(
                              onTap: () {
                                ref.read(tabController.notifier).state =
                                    GuestTab.waiting;
                              },
                              text: 'Waiting',
                              selected: tController == GuestTab.waiting),
                          const SortList(),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Consumer(
                        builder: (context, ref, child) {
                          final controller = ref.watch(homeListProvider);
                          if (controller is HomeListLoaded) {
                            return resultWidget(controller.guests, search);
                          } else if (controller is HomeListLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return const NoEntryBooking(
                                content: "No guests found ");
                          }
                        },
                      ),
                      const SizedBox(
                        height: 120,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: CustomButton(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 84),
            height: 45,
            width: 145,
            onTap: () {
              homeSearchController.clear();
              ref.read(nameSearchProvider.notifier).state = '';
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const QRViewExample()));
            },
            child: const Image(
              image: AssetImage('assets/images/check_in.png'),
              fit: BoxFit.contain,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }

  Widget resultWidget(List<BookingCloudData> result, String search) {
    if (result.isEmpty) {
      if (search.isEmpty /* ?? true) || search == null */) {
        return const NoEntryBooking(content: "No guests found");
      } else {
        return NoEntryBooking(content: "Can't find '$search'");
      }
    } else {
      return Column(
        children: [
          ...result.map((guest) => GuestCard(
                data: guest,
              )),
        ],
      );
    }
  }
}
