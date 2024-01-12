import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:htp_concierge/features/dashboard/controller/dashboard_page_index.dart';
import 'package:htp_concierge/features/dashboard/controller/widget_controller/search_controller.dart';

class FloatingButtons extends ConsumerWidget {
  const FloatingButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(dashboardPageIndexProvider);

    final homeSearchController = ref.watch(homeControllerProvider);
    final upcomingSearchController = ref.watch(upcomingControllerProvider);
    final pastSearchController = ref.watch(pastControllerProvider);

    return Container(
        padding: const EdgeInsets.all(15),
        height: 67,
        width: 300,
        decoration: BoxDecoration(
            color: const Color(0xff242222),
            borderRadius: BorderRadius.circular(40)),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  ref.read(dashboardPageIndexProvider.notifier).state =
                      DashboardTab.home;

                  upcomingSearchController.clear();
                  pastSearchController.clear();
                  ref.read(newNameSearchProvider.notifier).state = "";
                  ref.read(pastNameSearchProvider.notifier).state = "";
                },
                child: SizedBox(
                  width: 65,
                  height: 65,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        controller == DashboardTab.home
                            ? SvgPicture.asset(
                                'assets/svgimages/fbc_1.svg',
                                width: 18,
                                height: 18,
                              )
                            : SvgPicture.asset(
                                'assets/svgimages/fb_1.svg',
                                width: 18,
                                height: 18,
                              ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Home",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              //SizedBox(width: 10,),
              Container(
                height: 45,
                width: 2,
                color: Colors.grey,
              ),
              //  SizedBox(width: 10,),
              GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    ref.read(dashboardPageIndexProvider.notifier).state =
                        DashboardTab.upcoming;

                    homeSearchController.clear();
                    pastSearchController.clear();
                    ref.read(nameSearchProvider.notifier).state = '';
                    ref.read(pastNameSearchProvider.notifier).state = '';
                  },
                  child: Container(
                    color: Colors.transparent,
                    width: 65,
                    height: 65,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        controller == DashboardTab.upcoming
                            ? SvgPicture.asset(
                                'assets/svgimages/fbc_2.svg',
                                width: 20,
                                height: 20,
                              )
                            : SvgPicture.asset(
                                'assets/svgimages/fb_2.svg',
                                width: 20,
                                height: 20,
                              ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Upcoming",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ],
                    ),
                  )),
              Container(
                height: 45,
                width: 2,
                color: Colors.grey,
              ),
              // SizedBox(width: 10,),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  ref.read(dashboardPageIndexProvider.notifier).state =
                      DashboardTab.past;
// ref.refresh(postSelectedDateProvider);

                  homeSearchController.clear();
                  upcomingSearchController.clear();
                  // ref.read(nameSearchProvider.notifier).state = '';
                  // ref.read(newNameSearchProvider.notifier).state = '';
                  ref.invalidate(nameSearchProvider);
                  ref.invalidate(newNameSearchProvider);
                },
                child: SizedBox(
                  width: 65,
                  height: 65,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      controller == DashboardTab.past
                          ? SvgPicture.asset(
                              'assets/svgimages/fbc_3.svg',
                              width: 20,
                              height: 20,
                            )
                          : SvgPicture.asset(
                              'assets/svgimages/fb_3.svg',
                              width: 20,
                              height: 20,
                            ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Past Guests",
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      )
                    ],
                  ),
                ),
              )
            ]));
  }
}
