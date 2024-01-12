import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/club_booking_list.dart';

final firebasedbProvider = Provider((ref) {
  return FireServices();
});

class FireServices {
  FireServices() {
    user = FirebaseAuth.instance.currentUser;
  }
  User? user;
  final db = FirebaseFirestore.instance;

//----------------------------------- getFirebaseDetails -----------------------------------------
  Future<List<BookingCloudData>> getFirebaseDetails(
      DateTime selectedData) async {
    try {
      final idTokenResult = await user?.getIdTokenResult(true);
      String clubId = await idTokenResult?.claims?["club_id"];

      final today =
          DateTime(selectedData.year, selectedData.month, selectedData.day);

      Timestamp date = Timestamp.fromDate(today);
      final nextDate = Timestamp.fromDate(today.add(const Duration(days: 1)));

      final clubSnapshot = await db
          .collection("club_entry_bookings")
          // .where("status", isEqualTo: "Approved")
          .where("status", whereIn: ["Approved", "Completed"])
          // .where("status", isEqualTo: "Completed")
          .where("booking_date", isGreaterThanOrEqualTo: date)
          .where("booking_date", isLessThan: nextDate)
          .where("club_id", isEqualTo: clubId)
          .get();

      final clubListData = clubSnapshot.docs
          .map((e) => BookingCloudData.fromSnapshot(e))
          .toList();

      final eventSnapshot = await db
          .collection("event_entry_bookings")
          // .where("status", isEqualTo: "Approved")
          // .where("status", isEqualTo: "Completed")
          .where("status", whereIn: ["Approved", "Completed"])
          .where("booking_date", isGreaterThanOrEqualTo: date)
          .where("booking_date", isLessThan: nextDate)
          .where("club_id", isEqualTo: clubId)
          .get();

      final eventListData = eventSnapshot.docs
          .map((e) => BookingCloudData.fromSnapshot(e))
          .toList();

      final totalList = clubListData + eventListData;

      return totalList;
    } on FirebaseAuthException catch (e) {
      if (e.code ==
          "A network error (such as timeout, interrupted connection or unreachable host) has occurred") {
        List<BookingCloudData> totalList = [];
        return totalList;
      } else {
        if (e.code == "network-request-failed") {
          List<BookingCloudData> totalList = [];
          return totalList;
        } else {
          debugPrint(e.code);
          List<BookingCloudData> totalList = [];
          return totalList;
        }
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future getGuestDetails(String documentId, String collectionName) async {
    final snapshots = await db.collection(collectionName).doc(documentId).get();
    final mapData = snapshots.data();
    return mapData;
  }

  firebaseClubId() async {
    User? user = FirebaseAuth.instance.currentUser;
    final idTokenResult = await user?.getIdTokenResult(true);
    String clubId = await idTokenResult?.claims?["club_id"];

    return clubId;
  }

//----------------------------------------------Club Details --------------------------------
  Future<Map<String, dynamic>?> clubDetails(String clubId) async {
    // User? user = FirebaseAuth.instance.currentUser;
    try {
      final clubDetailsSnapshot =
          await db.collection('clubs').doc(clubId).get();
      return clubDetailsSnapshot.data();
      // debugPrint("---------------------------- ${clubDetailsSnapshot.data()}");
      // if (clubDetailsSnapshot.data() == null) {
      //   // await FirebaseAuth.instance.signOut();
      // } else {
      //   return clubDetailsSnapshot.data();
      // }
    } catch (e) {
      print("-------------------------" + e.toString());
      rethrow;
    }
  }

  //---------------------------------------------------------------------------

  Future firebaseUserId(String membershipId) async {
    final activeId = await db
        .collection("users")
        .where("active_membership_id", isEqualTo: membershipId)
        .get();

    // var id;
    List<String> finalId = [];

    for (var qsnapshot in activeId.docs) {
      var id = qsnapshot.id;
      finalId.add(id);
    }
    return finalId;
  }

  Future userDetails(String userId) async {
    userId = userId.replaceAll(' ', '');

    final snapshot =
        await db.collection('users').where("id", isEqualTo: userId).get();
    for (var element in snapshot.docs) {
      final eId = element.id.replaceAll(' ', '');

      if (eId == userId) {
        return element.data();
      }
    }
  }
}
