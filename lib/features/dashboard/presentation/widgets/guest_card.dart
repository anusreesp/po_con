import 'package:change_case/change_case.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:htp_concierge/features/dashboard/data/models/club_booking_list.dart';

import '../screens/guest_details.dart';

// ignore: must_be_immutable
class GuestCard extends ConsumerWidget {
  final BookingCloudData data;
  bool isHome;
  GuestCard({Key? key, required this.data, this.isHome = false})
      : super(key: key);
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GuestDetails(
                      docId: data.id,
                      bookingType: data.bookingType,
                    )));
      },
      child: SizedBox(
        height: isHome ? 130 : 125,
        child: Card(
          color: const Color(0xff000000),
          margin: const EdgeInsets.only(bottom: 10),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(isHome ? 12 : 0)),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                const SizedBox(
                  width: 12,
                ),
                Column(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: const Color(0xffE0C356),
                      child: CircleAvatar(
                        backgroundImage: data.userProfileImage != null
                            ? NetworkImage(data.userProfileImage!)
                            : const AssetImage("assets/images/profile_icon.png")
                                as ImageProvider,
                        radius: 30,
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 2.0,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset((data.bookingStatus == "Completed" &&
                                data.isCheckedIn == true)
                            ? "assets/svgimages/Tick icon.svg"
                            : "assets/svgimages/Minus icon.svg"),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          (data.bookingStatus /* != null */ == "Completed" &&
                                  data.isCheckedIn == true)
                              ? "Checked-in"
                              : "Waiting",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        )
                      ],
                    )
                  ],
                ),

                const Spacer(),

                ///Right side of card
                SizedBox(
                  width: 110,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Booking ID",
                        style: TextStyle(
                            fontSize: 12,
                            //fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                      Text(
                        data.bookingId.toString(),
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(
                        height: 9.0,
                      ),
                      const Text(
                        "Guest Name",
                        style: TextStyle(
                            fontSize: 12.0,
                            //fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                      Text(data.userName?.toTitleCase() ?? "userName",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
