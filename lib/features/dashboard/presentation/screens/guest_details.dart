import 'package:change_case/change_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:htp_concierge/features/dashboard/controller/widget_controller/floating_button_controller.dart';
import 'package:htp_concierge/features/dashboard/data/services/firebase_services.dart';
import 'package:htp_concierge/features/dashboard/presentation/widgets/dialog_box.dart';
import 'package:htp_concierge/features/dashboard/presentation/widgets/guest_widget/guest_data.dart';
import 'package:intl/intl.dart';
import '../../../../core/widgets/dashed_line.dart';
import '../widgets/guest_widget/floating_button.dart';
import '../widgets/guest_widget/guest_details_card.dart';

final clubIdValProvider = FutureProvider.autoDispose(
    (ref) async => await FireServices().firebaseClubId());

class GuestDetails extends ConsumerWidget {
  // static const route = "/guest-details";
  final String docId;
  final String bookingType;
  const GuestDetails({Key? key, required this.docId, required this.bookingType})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clubIdController = ref.watch(clubIdValProvider);
    final firebaseController = ref.read(firebasedbProvider);

    String collectionName = "";
    if (bookingType == "event_entry_booking") {
      collectionName = "event_entry_bookings";
    } else {
      collectionName = "club_entry_bookings";
    }

    //------------------------futureBuilder
    return FutureBuilder(
        future: firebaseController.getGuestDetails(docId, collectionName),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return clubIdController.when(data: (data) {
              final snapClubId = snapshot.data['club_id'];
              final bookedDate = snapshot.data['booking_date'].toDate();

              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                ref.read(isCheckedProvider.notifier).state =
                    snapshot.data['isCheckedIn'];

                ref.read(statusProvider.notifier).state =
                    snapshot.data['status'];
              });

              return Scaffold(
                backgroundColor: const Color(0xff171717),
                appBar: AppBar(
                  leading: Builder(
                    builder: (BuildContext context) {
                      return IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Color(0xffFFFFFF),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        tooltip: MaterialLocalizations.of(context)
                            .openAppDrawerTooltip,
                      );
                    },
                  ),
                  title: const Text(
                    "Guest List",
                    style: TextStyle(
                        color: Color(0xffFFFFFF),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  titleSpacing: 1,
                ),
                body: SingleChildScrollView(
                  child: Center(
                    child: (snapClubId == data &&
                            (snapshot.data['status'] == 'Approved' ||
                                snapshot.data['status'] == 'Completed'))
                        ? Column(
                            children: [
                              GuestDetailsCard(
                                data: snapshot.data,
                                documentId: docId,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Details(
                                data: snapshot.data,
                                collectionName: collectionName,
                              ),
                              const SizedBox(
                                height: 48,
                              ),

                              //
                            ],
                          )
                        : Container(
                            child: invalidQR(context, ref),
                          ),
                  ),
                ),
                floatingActionButton: AnimatedFloatingButton(
                  bookedDate: bookedDate,
                  collectionName: collectionName,
                  docId: docId,
                  isChecked: snapshot.data["isCheckedIn"] ?? false,
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
              );
            }, error: (error, stack) {
              return const Text('Something went wrong !');
            }, loading: () {
              return const Center(child: CircularProgressIndicator());
            });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  invalidQR(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
              barrierDismissible: false,
              useRootNavigator: true,
              builder: (BuildContext context) {
                return ref.read(dialogBoxProvider).confirmationPopup(
                    context,
                    "denied.png",
                    "Entry Access denied",
                    "Invalid QR Code",
                    true);
              },
              context: context)
          .then((value) {
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      });
    });
  }
}

class Details extends ConsumerWidget {
  final Map<String, dynamic> data;
  final String collectionName;
  const Details({
    Key? key,
    required this.data,
    required this.collectionName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = data['people'].length + 1;

    final date = data["booking_date"].toDate();
    final month = DateFormat('MMMM').format(date);
    final expectedTime = data['expected_arrival_time'];

    final bookTime = DateFormat.jm().format(date);
    String timeZone = data["country_time_zone"];

    final bookingTime = bookTime + " " + timeZone;

    String bookingType;
    if (data['booking_type'] == 'table_booking') {
      bookingType = "Club table";
    } else if (data['booking_type'] == 'club_entry_booking') {
      bookingType = 'Club entry';
    } else {
      bookingType = 'Event booking';
    }

    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xff000000)),
        padding:
            const EdgeInsets.only(left: 26, top: 11, right: 10, bottom: 10),
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            SvgPicture.asset("assets/svgimages/qrcode.svg"),
            const SizedBox(
              height: 20,
            ),
            const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Booking Details',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffFFFFFF)),
                )),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BookingDetails(
                        imageUrl: 'assets/svgimages/bottle.svg',
                        title: 'Club Name',
                        name: data["club_name"].toString().toTitleCase()),
                    BookingDetails(
                        imageUrl: 'assets/svgimages/calendericon.svg',
                        title: 'Booking Date',
                        name:
                            '${date.day} $month, ${date.year}\n ${expectedTime ?? bookingTime}'),
                    const SizedBox(
                      height: 8,
                    ),
                    BookingDetails(
                      isPng: true,
                      imageUrl: "assets/images/booking-type.png",
                      title: 'Booking Type',
                      name: bookingType,
                    )
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BookingDetails(
                      imageUrl: 'assets/svgimages/location.svg',
                      title: 'Location',
                      name: data["club_location"].toString().toTitleCase(),
                    ),
                    BookingDetails(
                        // isPng: true,
                        imageUrl: 'assets/svgimages/guests.svg',
                        size: 12,
                        title: "Guest Count",
                        name: "$count"),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 16,
                ),
              ],
            ),
            const SizedBox(
              height: 6.0,
            ),
            DashedLine(width: MediaQuery.of(context).size.width * 0.9),
            const SizedBox(
              height: 32,
            ),
            //----------------------------------Attendees Data------------------------------------------
            Column(
              children: [
                SizedBox(height: 120, child: GuestData(data: data)),
                const SizedBox(
                  height: 32,
                ),
              ],
            ),

            // DashedLine(width: MediaQuery.of(context).size.width * 0.9),
            // const SizedBox(
            //   height: 35,
            // ),

            //--------------------------------------Products Details-------------------------------------
            // ProductDetails(
            //   data: data,
            //   productAvailable: (data['preferred_products'] == null ||
            //           data['preferred_products'].isEmpty)
            //       ? false
            //       : true,
            //   collectionName: collectionName,
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
          ],
        ));
  }
}

class BookingDetails extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String name;
  final bool isPng;
  final double size;

  const BookingDetails(
      {Key? key,
      required this.imageUrl,
      required this.title,
      required this.name,
      this.size = 16,
      this.isPng = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isPng
            ? Image.asset(
                imageUrl,
                width: 16,
                height: 16,
              )
            : SvgPicture.asset(
                imageUrl,
                width: size,
                height: size,
                color: Color(0xffD3BB8A),
              ),
        const SizedBox(
          width: 12,
        ),
        SizedBox(
          height: 50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.grey, fontSize: 10),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                name,
                style: const TextStyle(color: Color(0xffFFFFFF), fontSize: 14),
              ),
            ],
          ),
        )
      ],
    );
  }
}
