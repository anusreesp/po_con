import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:htp_concierge/features/dashboard/controller/widget_controller/sort_controller.dart';
import '../../data/services/firebase_services.dart';

class SortList extends StatefulWidget {
  const SortList({super.key});

  @override
  State<SortList> createState() => _SortListState();
}

class _SortListState extends State<SortList> {
  List sortDataList = ['Solitaire', 'Platinum', 'Gold', 'Silver', 'Amethyst'];
  String sortData = "";

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        return PopupMenuButton<int>(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: const Color(0xff272222),
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/svgimages/sort.svg",
                height: 14,
                width: 8,
              ),
              const SizedBox(
                width: 4,
              ),
              const Text(
                'Sort',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                onTap: () {
                  setState(() {
                    sortData = "";
                  });
                  ref.read(sortProvider.notifier).state = sortData;
                },
                value: -1,
                child: const Text(
                  "Member Type",
                  style: TextStyle(
                      color: Color(0xffB68708), fontWeight: FontWeight.bold),
                ),
              ),
              ...sortDataList.map((val) {
                return PopupMenuItem(
                  value: sortDataList.indexOf(val),
                  onTap: () async {
                    setState(() {
                      sortData = val;
                    });
                    ref.read(membershipSortProvider.notifier).state =
                        await sortDataValue(sortData);
                    ref.read(sortProvider.notifier).state = sortData;
                  },
                  child: Row(
                    children: [
                      Text(
                        val,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      if (val == sortData)
                        const Icon(
                          Icons.check,
                          color: Color(0xffE2B02A),
                        )
                    ],
                  ),
                );
              }),
            ];
          },
        );
      },
    );
  }

  sortDataValue(String selectedData) async {
    final db = FirebaseFirestore.instance;
    final snapshots = await db
        .collection("memberships")
        .where("name", isEqualTo: selectedData)
        .get();
    String documentID;
    for (var qsnapshot in snapshots.docs) {
      documentID = qsnapshot.id; // <-- Document ID

      return await FireServices().firebaseUserId(documentID);
    }
  }
}
