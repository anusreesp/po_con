import 'package:change_case/change_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/services/firebase_services.dart';

// ignore: must_be_immutable
class GuestData extends ConsumerWidget {
  Map<String, dynamic> data;
  GuestData({required this.data, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fireDbProvider = ref.watch(firebasedbProvider);
    // final userid = data['user']['user_id'];

    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Guests',
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xffFFFFFF)),
          ),
        ),
        const SizedBox(
          height: 12,
        ),

        // (data['people'].length != 0)
        // ?
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 150,
                child: Text(
                  // "Attendee's Name",
                  'Name',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
              SizedBox(
                  width: 25,
                  child: Text(
                    "Age",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  )),
              SizedBox(
                  width: 50,
                  child: Text(
                    "Gender",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ))
            ],
          ),
        ),
        // : Container(),
        const SizedBox(
          height: 5,
        ),
        // Align(alignment: Alignment.centerLeft, child: Text(addBookedGuest())),
        SizedBox(
          height: 75,
          child: SingleChildScrollView(
            child: Column(
              children: [
                FutureBuilder(
                    future: fireDbProvider.userDetails(data['user']['id']),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          final userDetails = snapshot.data;

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 146,
                                    child: Text(
                                      userDetails["name"]
                                          .toString()
                                          .toTitleCase(),
                                    ),
                                  ),
                                  // Spacer(),
                                  SizedBox(
                                      width: 26,
                                      child: Text(
                                          // "age"
                                          userDetails["dob"] != null
                                              ? calculateAge(userDetails["dob"])
                                              : " -")),
                                  SizedBox(
                                    width: 46,
                                    height: 15,
                                    child: Text(userDetails["gender"] != null
                                        ? genderVal(userDetails["gender"])
                                        : '-'),
                                  ),
                                ]),
                          );
                        } else {
                          return const Text("No data found");
                        }
                      } else {
                        return const Center(
                            // child: CircularProgressIndicator(),
                            );
                      }
                    }),

                //--------------------------------- Attendees  list------------------
                // (data['people'].length != 0)
                ListView.builder(
                    itemCount: data['people'].length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int i) {
                      final peopleDetails = data['people'][i];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 146,
                              child: Text(
                                peopleDetails['name'] == "-"
                                    ? "Guest ${++i}"
                                    : peopleDetails["name"]
                                        .toString()
                                        .toTitleCase(),
                              ),
                            ),
                            SizedBox(
                                width: 26,
                                child: Text("${peopleDetails["age"]}")),
                            SizedBox(
                                width: 45,
                                child: Text(peopleDetails["gender"] == null
                                    ? "-"
                                    : genderVal(peopleDetails["gender"])))
                          ],
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
        // : const Center(
        //     child: Text("No guests found....!"),
        //   )
      ],
    );
  }

  String calculateAge(String birthDate) {
    DateTime currentDate = DateTime.now();
    var birthDateSplit = birthDate.split("-");
    int date = int.parse(birthDateSplit[0]);
    int month = int.parse(birthDateSplit[1]);
    int year = int.parse(birthDateSplit[2]);

    // int age = currentDate.year - birthDate.year;
    int age = currentDate.year - year;
    int month1 = currentDate.month;
    // int month2 = birthDate.month;
    if (month > month1) {
      age--;
    } else if (month1 == month) {
      int day1 = currentDate.day;
      // int day2 = birthDate.date;
      if (date > day1) {
        age--;
      }
    }
    return age.toString();
    // return birthDateSplit[0];
  }

  String genderVal(String val) {
    if (val == 'Male' || val == 'male') {
      return 'M';
    } else if (val == 'Female' || val == 'female') {
      return 'F';
    } else {
      return '-';
    }
  }
}
