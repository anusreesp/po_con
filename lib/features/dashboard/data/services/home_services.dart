// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../controller/tab_controller.dart';
// import '../models/club_booking_list.dart';

// final homeServiceProvider = FutureProvider((ref) {
//   return HomeServices();
// });

// class HomeServices {
//   HomeServices();

//   List<BookingCloudData> filterList(
//       List<BookingCloudData> guestList, GuestTab type) {
//     try {
//       switch (type) {
//         case GuestTab.all:
//           return guestList;

//         case GuestTab.checkedIn:
//           return guestList
//               .where((element) => (element.isCheckedIn == true))
//               .toList();

//         case GuestTab.waiting:
//           return guestList
//               .where((element) => (element.isCheckedIn == false))
//               .toList();
//       }
//     } catch (_) {
//       return [];
//     }
//   }
// }
