// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:htp_concierge/features/dashboard/controller/search_controller.dart';
// import 'package:htp_concierge/features/dashboard/controller/sort_controller.dart';
// import 'package:htp_concierge/features/dashboard/controller/tab_controller.dart';
// import 'package:htp_concierge/features/dashboard/data/models/club_booking_list.dart';

// final homeGuestProvider = StateNotifierProvider.family<HomeGuestController,
//     List<BookingCloudData>, List<BookingCloudData>>((ref, guests) {
//   final tController = ref.watch(tabController);
//   final search = ref.watch(nameSearchProvider);
//   final sort = ref.watch(sortProvider);
//   // final homeSortResult = ref.watch(homeSortProvider(guests));

//   final userid = ref.watch(membershipSortProvider);

//   return HomeGuestController(
//       guests, tController, search, sort, userid /* , homeSortResult */);
// });

// class HomeGuestController extends StateNotifier<List<BookingCloudData>> {
//   final List<BookingCloudData> guests;
//   final GuestTab selectedTab;
//   final String search;
//   final String sort;
//   final List<String> userid;
//   // final List<BookingCloudData> homeSortResult;

//   HomeGuestController(
//     this.guests,
//     this.selectedTab,
//     this.search,
//     this.sort,
//     this.userid,
//     /* this.homeSortResult */
//   ) : super([]) {
//     init();
//   }

//   init() {
//     List<BookingCloudData> guestDataList = guests;
//     if (search.isNotEmpty) {
//       guestDataList = sortVal(guestDataList);

//       final number = num.tryParse(search);
//       if (number != null) {
//         state = guestDataList
//             .where((element) => element.bookingId.toString().contains(search))
//             .toList();
//       } else {
//         state = guestDataList
//             .where((element) =>
//                 element.userName!.toLowerCase().contains(search.toLowerCase()))
//             .toList();
//       }
//     } else {
//       state = sortVal(guestDataList);
//     }
//   }

//   sortVal(List<BookingCloudData> guestDataList) {
//     List<BookingCloudData> dataList = [];

//     if (sort.isNotEmpty) {
//       if (guestDataList
//           .every((element) => element.userMembershipName?.isEmpty == false)) {
//         dataList = guestDataList
//             .where((element) => element.userMembershipName!.contains(sort))
//             .toList();
//       } else {
//         for (var i = 0; i < userid.length; i++) {
//           dataList = guestDataList.where((e) {
//             return userid.contains(e.userId);
//           }).toList();
//         }
//       }
//     } else {
//       dataList = guestDataList;
//     }
//     return dataList;
//   }
// }
