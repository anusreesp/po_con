// // To parse this JSON data, do
// //
// //     final clubBookingList = clubBookingListFromJson(jsonString);

// import 'dart:convert';

// ClubBookingList clubBookingListFromJson(String str) => ClubBookingList.fromJson(json.decode(str));

// String clubBookingListToJson(ClubBookingList data) => json.encode(data.toJson());

// class ClubBookingList {
//   ClubBookingList({
//     required this.success,
//     required this.data,
//     required this.count,
//   });

//   final bool success;
//   final List<BookingData> data;
//   final int count;

//   factory ClubBookingList.fromJson(Map<String, dynamic> json) => ClubBookingList(
//     success: json["success"],
//     data: List<BookingData>.from(json["data"].map((x) => BookingData.fromJson(x))),
//     count: json["count"],
//   );

//   Map<String, dynamic> toJson() => {
//     "success": success,
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//     "count": count,
//   };
// }

// class BookingData {
//   BookingData({
//     required this.id,
//     required this.bookingId,
//     required this.user,
//     required this.checkedIn,
//     required this.userName,
//     required this.userProfileImage,
//   });

//   final String id;
//   final String bookingId;
//   final String user;
//   final bool checkedIn;
//   final String userName;
//   final String userProfileImage;

//   factory BookingData.fromJson(Map<String, dynamic> json) => BookingData(
//     id: json["id"],
//     bookingId: json["booking_id"],
//     user: json["user"],
//     checkedIn: json["checked_in"],
//     userName: json["user_name"],
//     userProfileImage: json["user_profile_image"],
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "booking_id": bookingId,
//     "user": user,
//     "checked_in": checkedIn,
//     "user_name": userName,
//     "user_profile_image": userProfileImage,
//   };
// }
