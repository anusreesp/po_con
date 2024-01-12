import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_concierge/features/auth/presentation/widgets/custom_search_box.dart';
import 'package:htp_concierge/features/dashboard/controller/guest_list_controller.dart';
import 'package:htp_concierge/features/dashboard/controller/widget_controller/search_controller.dart';
import 'package:htp_concierge/features/dashboard/presentation/widgets/table_calender.dart';
import 'package:intl/intl.dart';
import '../../../../exception_handling/no_bookings_exception.dart';
import '../../controller/guest_data_controller.dart';
import '../../data/models/club_booking_list.dart';
import '../widgets/guest_card.dart';

class PastGuestList extends ConsumerWidget {
  const PastGuestList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDateController = ref.watch(postSelectedDateProvider);

    final search = ref.watch(pastNameSearchProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref
            .read(guestDataListProvider(selectedDateController).notifier)
            .getGuests();
      },
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: const Color(0xff171717),
            title: const Text(
              "Past guest list ",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
          backgroundColor: const Color(0xff171717),
          body: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 90, top: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      Expanded(
                        child: TableCalenderWidget(
                          firstDay: DateTime.utc(2010, 10, 16),
                          lastDay:
                              DateTime.now().subtract(const Duration(days: 1)),
                          selectedDateController: selectedDateController,
                          onDaySelected: (selectedDay, focusedDay) {
                            ref.read(postSelectedDateProvider.notifier).state =
                                selectedDay;
                          },
                        ),
                      ),
                      GestureDetector(
                          onTap: () async {
                            DateTime selectedDate = DateTime.now()
                                .subtract(const Duration(days: 1));
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: ref.read(postSelectedDateProvider),
                              firstDate: DateTime.utc(2010, 01, 31),
                              lastDate: DateTime.now()
                                  .subtract(const Duration(days: 1)),
                            );
                            if (picked != null && picked != selectedDate) {
                              ref
                                  .read(postSelectedDateProvider.notifier)
                                  .state = picked;
                            }
                          },
                          child: const Image(
                            image: AssetImage('assets/images/calender.png'),
                            height: 20,
                            width: 20,
                          ))
                    ]),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const CustomSearchBox(
                      page: 'past',
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Consumer(
                      builder: (context, ref, _) {
                        final controller = ref.watch(
                            guestDataListProvider(selectedDateController));

                        if (controller is GuestDataListLoaded) {
                          final month =
                              DateFormat('MMMM').format(selectedDateController);

                          return Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(6, 5, 0, 3),
                                  child: Text(
                                    '${selectedDateController.day} $month, ${selectedDateController.year}',
                                    style: const TextStyle(
                                        fontSize: 15, color: Color(0xffFFFFFF)),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(6, 5, 0, 4),
                                  child: Text(
                                    'Total booking: ${controller.guests.length}',
                                    style: const TextStyle(
                                        fontSize: 12, color: Color(0xffFFFFFF)),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              _resultVal(search, controller.guests)
                            ],
                          );
                        } else if (controller is GuestDataListLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return const NoEntryBooking(
                              content: "No guests found ");
                        }
                      },
                    )
                  ],
                ),
              ))),
    );
  }

  Widget _resultVal(String search, List<BookingCloudData> result) {
    if (result.isEmpty) {
      if (search.isEmpty) {
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
