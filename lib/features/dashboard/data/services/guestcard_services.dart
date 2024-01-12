import '../models/club_booking_list.dart';

class GuestCardServices {
  List<BookingCloudData> searchValue(
      String? search, List<BookingCloudData>? guestList) {
    List<BookingCloudData> result = [];
    if (search == null) {
      result = guestList!;
    } else {
      final number = num.tryParse(search);
      if (number != null) {
        result = guestList!
            .where((element) => element.bookingId.toString().contains(search))
            .toList();
      } else {
        result = guestList!
            .where((element) =>
                element.userName!.toLowerCase().contains(search.toLowerCase()))
            .toList();
      }
    }

    return result;
  }
}
