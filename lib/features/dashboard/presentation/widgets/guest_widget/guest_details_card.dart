import 'package:change_case/change_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../controller/widget_controller/floating_button_controller.dart';
import 'display_img.dart';

class GuestDetailsCard extends ConsumerWidget {
  final Map<String, dynamic> data;
  final String documentId;

  const GuestDetailsCard({
    Key? key,
    required this.documentId,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.only(left: 24, top: 11, right: 10, bottom: 10),
      height: 157,
      // width: 350,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.black),
      child: SizedBox(
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (data["user"]?["profile_image"] !=
                                        null) {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return DetailScreen(
                                          src: data["user"]?["profile_image"],
                                        );
                                      }));
                                    }
                                  },
                                  child: Stack(
                                      alignment: AlignmentDirectional.center,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          radius: 40,
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: const Image(
                                                image: AssetImage(
                                                    'assets/images/Mask Group 3.png'),
                                              ),
                                            ),
                                          ),
                                        ),
                                        CircleAvatar(
                                          radius: 35,
                                          backgroundColor:
                                              const Color(0xffE0C356),
                                          child: CircleAvatar(
                                            backgroundImage: /* ImageUrl */
                                                data["user"]?[
                                                            "profile_image"] !=
                                                        null
                                                    ? NetworkImage(data["user"]
                                                        ?["profile_image"]!)
                                                    : const AssetImage(
                                                            "assets/images/profile_icon.png")
                                                        as ImageProvider,
                                            radius: 30,
                                            child: const Padding(
                                              padding: EdgeInsets.all(8),
                                            ),
                                          ),
                                        ),
                                        CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          //radius: 40,
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: SvgPicture.asset(
                                                    "assets/svgimages/Stretch pic Icon.svg")),
                                          ),
                                        )
                                      ]),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),

                                const Text(
                                  'Booked By',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                                const SizedBox(height: 2),

                                // ;
                                //     }),
                              ],
                            ),
                            SizedBox(
                              // width: 180,
                              // width: MediaQuery.of(context).size.width * 0.50,
                              child: Text(
                                data["user"]["name"].toString().toTitleCase(),
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Spacer(),

            ///----------------------------------------------------------Right section
            Expanded(
              child: SizedBox(
                // height: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    const Text(
                      'Booking ID',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                        /* guestController */ data["booking_id"]
                            .toString() /* ?? "" */,
                        style: Theme.of(context).textTheme.displayMedium),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset((ref.watch(isCheckedProvider) &&
                                ref.watch(statusProvider) == "Completed"
                            // data["isCheckedIn"] == true
                            )
                            ? "assets/svgimages/Tick icon.svg"
                            : "assets/svgimages/Minus icon.svg"),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          (ref.watch(isCheckedProvider)
                                  // data["isCheckedIn"] == true
                                  &&
                                  ref.watch(statusProvider) == "Completed")
                              ? "Checked-in"
                              : "Waiting",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      data["user"]["membership_name"] != null
                          ? " ${data["user"]["membership_name"]}\n Member"
                          : 'MemberShip Name',
                      style: const TextStyle(
                          fontSize: 13.5, color: Color(0xffFFFFFF)),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
