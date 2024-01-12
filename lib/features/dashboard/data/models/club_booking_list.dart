// To parse this JSON data, do
//
//     final clubBookingList = clubBookingListFromJson(jsonString);

import 'package:cloud_firestore/cloud_firestore.dart';

class BookingCloudData {
  BookingCloudData({
    required this.id,
    required this.bookingId,
    required this.bookingStatus,
    this.isCheckedIn,
    required this.bookingType,
    this.people,
    this.bookingDate,
    this.clubName,
    this.clubLocation,
    this.userName,
    this.userId,
    this.userUserId,
    this.userProfileImage,
    this.userMembershipName,
    // required this.userProfileImage,
  });

  final String id;
  final int bookingId;
  Timestamp? bookingDate;
  final bool? isCheckedIn;
  final String bookingStatus;
  final String bookingType;
  List? people;
  String? clubName;
  String? clubLocation;
  String? userName;
  String? userProfileImage;
  String? userId;
  String? userUserId;
  String? userMembershipName;

  factory BookingCloudData.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final datas = document.data();
    Map<String, dynamic>? users = datas!["user"];
    // Array people = datas['people'];

    return BookingCloudData(
        id: document.id,
        bookingId: datas["booking_id"],
        bookingDate: datas["booking_date"],
        bookingType: datas["booking_type"],
        bookingStatus: datas["status"],
        isCheckedIn: datas["isCheckedIn"] ?? false,
        clubName: datas["club_name"],
        clubLocation: datas["club_location"],
        userName: users?["name"],
        userProfileImage: users?["profile_image"],
        userId: users?["id"],
        userUserId: users?["user_id"],
        userMembershipName: users?["membership_name"],
        people: datas['people']

        // userProfileImage: data["user"].docs.data["profile_image"],
        );
  }
}
