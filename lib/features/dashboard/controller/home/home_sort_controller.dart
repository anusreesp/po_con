// import 'package:flutter/foundation.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:htp_concierge/features/dashboard/data/models/club_booking_list.dart';

// import '../sort_controller.dart';
// import 'home_lists.controller.dart';

// final homeSortProvider = StateNotifierProvider.family<HomeSortNotifier,
//     List<BookingCloudData>, List<BookingCloudData>>((ref, guests) {
//   final filterdata = ref.watch(sortProvider);
//   // final fireHomeListController = ref.watch(homeListProvider(DateTime.now()));

//   // if (fireHomeListController is HomeListLoaded) {
//   //   return HomeSortNotifier(fireHomeListController.guests, filterdata);
//   // } else {
//   //   return HomeSortNotifier([], filterdata);
//   // }

//   return HomeSortNotifier(guests, filterdata);
// });

// class HomeSortNotifier extends StateNotifier<List<BookingCloudData>> {
//   final List<BookingCloudData> cloudData;
//   String filterType;

//   HomeSortNotifier(this.cloudData, this.filterType) : super(cloudData);

//   filterByMembership(filterType) {
//     debugPrint(filterType);

//     List<BookingCloudData> dataList = cloudData
//         .where((a) => a.userMembershipName!.contains(filterType))
//         .toList();

//     state = dataList;
//   }
// }
