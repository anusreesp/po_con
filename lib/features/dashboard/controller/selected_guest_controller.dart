// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final selectedGuestProvider = Provider<Guest>((ref) => Guest("", "", 0, ""));

// class Guest {
//   String name;
//   String documentId;
//   int bookingId;
//   String userProfileImage;

//   Guest(
//     this.name,
//     this.documentId,
//     this.bookingId,
//     this.userProfileImage,
//   );
// }

// // Timestamp time = " " as Timestamp;
// var timestamp = Timestamp.fromDate(DateTime.now());
// final guestBookingDetailProvider =
//     Provider<Booking>((ref) => Booking("", timestamp, "", "", "", false));

// class Booking {
//   String clubName;
//   String clubLocation;
//   Timestamp bookingDate;
//   String bookingStatus;
//   String bookingType;
//   bool isCheckedIn;
//   Booking(this.clubName, this.bookingDate, this.clubLocation, this.bookingType,
//       this.bookingStatus, this.isCheckedIn);
// }
