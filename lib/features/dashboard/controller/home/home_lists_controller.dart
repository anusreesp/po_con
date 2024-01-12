import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_concierge/features/dashboard/data/services/firebase_services.dart';

import '../../data/models/club_booking_list.dart';
import '../widget_controller/search_controller.dart';
import '../widget_controller/sort_controller.dart';
import '../widget_controller/tab_controller.dart';

final homeListProvider =
    StateNotifierProvider.autoDispose<HomeListController, HomeListStates>(
        (ref) {
  final fireServices = ref.watch(firebasedbProvider);
  final search = ref.watch(nameSearchProvider);
  final sort = ref.watch(sortProvider);
  final tController = ref.watch(tabController);
  final userid = ref.watch(membershipSortProvider);
  return HomeListController(fireServices, tController, search, sort, userid);
});

class HomeListController extends StateNotifier<HomeListStates> {
  FireServices fireDbServices;
  final GuestTab selectedTab;
  final String search;
  final String sort;
  final List<String> userid;

  HomeListController(this.fireDbServices, this.selectedTab, this.search,
      this.sort, this.userid)
      : super(HomeListInitial()) {
    getGuests();
  }

  getGuests() async {
    try {
      state = HomeListLoading();
      final newList = await fireDbServices.getFirebaseDetails(DateTime.now());
      final finalList = searchResult(newList);
      final filterlist = filterList(finalList, selectedTab);
      if (mounted) {
        state = HomeListLoaded(filterlist);
      }
    } catch (e) {
      state = HomeListError(e.toString());
    }
  }

  List<BookingCloudData> filterList(
      List<BookingCloudData> guestList, GuestTab type) {
    try {
      switch (type) {
        case GuestTab.all:
          return guestList;

        case GuestTab.checkedIn:
          return guestList
              .where((element) => (element.isCheckedIn == true))
              .toList();

        case GuestTab.waiting:
          return guestList
              .where((element) => (element.isCheckedIn == false))
              .toList();
      }
    } catch (_) {
      return [];
    }
  }

  List<BookingCloudData> searchResult(List<BookingCloudData> guestDataList) {
    List<BookingCloudData> guestList = [];

    if (search.isNotEmpty) {
      guestDataList = sortResult(guestDataList);
      final number = num.tryParse(search);
      if (number != null) {
        guestList = guestDataList
            .where((element) => element.bookingId.toString().contains(search))
            .toList();
      } else {
        guestList = guestDataList
            .where((element) =>
                element.userName!.toLowerCase().contains(search.toLowerCase()))
            .toList();
      }
    } else {
      guestList = sortResult(guestDataList);
    }
    return guestList;
  }

  List<BookingCloudData> sortResult(List<BookingCloudData> guestDataList) {
    List<BookingCloudData> dataList = [];

    if (sort.isNotEmpty) {
      if (guestDataList
          .every((element) => element.userMembershipName?.isEmpty == false)) {
        dataList = guestDataList
            .where((element) => element.userMembershipName!.contains(sort))
            .toList();
      } else {
        for (var i = 0; i < userid.length; i++) {
          dataList = guestDataList.where((e) {
            return userid.contains(e.userId);
          }).toList();
        }
      }
    } else {
      dataList = guestDataList;
    }
    return dataList;
  }
}

abstract class HomeListStates {}

class HomeListInitial extends HomeListStates {}

class HomeListLoading extends HomeListStates {}

class HomeListLoaded extends HomeListStates {
  final List<BookingCloudData> guests;
  HomeListLoaded(this.guests);
}

class HomeListError extends HomeListStates {
  final String msg;
  HomeListError(this.msg);
}
