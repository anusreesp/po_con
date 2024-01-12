import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_concierge/features/dashboard/controller/widget_controller/search_controller.dart';
import 'package:htp_concierge/features/dashboard/data/models/club_booking_list.dart';

import '../data/services/firebase_services.dart';

final guestDataListProvider = StateNotifierProvider.autoDispose
    .family<GuestDataListController, GuestDataListStates, DateTime>(
        (ref, selectedDate) {
  final fireDbServices = ref.watch(firebasedbProvider);

  String search = "";
  DateTime today = DateTime.now();
  if (selectedDate.isAfter(today)) {
    search = ref.watch(newNameSearchProvider);
  } else {
    search = ref.watch(pastNameSearchProvider);
  }

  return GuestDataListController(fireDbServices, selectedDate, search);
});

class GuestDataListController extends StateNotifier<GuestDataListStates> {
  FireServices fireDbServices;
  DateTime selectedDate;
  String search;
  GuestDataListController(this.fireDbServices, this.selectedDate, this.search)
      : super(GuestDataListLoading()) {
    getGuests();
  }

  getGuests() async {
    try {
      if (mounted) {
        state = GuestDataListLoading();
      }
      final newList = await fireDbServices.getFirebaseDetails(selectedDate);
      final finalList = searchValue(newList);

      if (mounted) {
        state = GuestDataListLoaded(finalList);
      }
    } catch (e) {
      state = GuestDataListError(e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    getGuests();
  }

  List<BookingCloudData> searchValue(List<BookingCloudData> guestList) {
    List<BookingCloudData> result = [];
    if (search.isEmpty) {
      result = guestList;
    } else {
      final number = num.tryParse(search);
      if (number != null) {
        result = guestList
            .where((element) => element.bookingId.toString().contains(search))
            .toList();
      } else {
        result = guestList
            .where((element) =>
                element.userName!.toLowerCase().contains(search.toLowerCase()))
            .toList();
      }
    }

    return result;
  }
}

abstract class GuestDataListStates {}

class GuestDataListLoading extends GuestDataListStates {}

class GuestDataListLoaded extends GuestDataListStates {
  List<BookingCloudData> guests;
  GuestDataListLoaded(this.guests);
}

class GuestDataListError extends GuestDataListStates {
  String msg;
  GuestDataListError(this.msg);
}
