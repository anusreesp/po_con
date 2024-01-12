
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:htp_concierge/features/auth/data/models/club_booking_list.dart';
// import 'package:htp_concierge/network_modules/http_client.dart';

// final serviceProvider = Provider((ref){
//   final client = ref.watch(clientProvider);
//   return AppServices(client);
// });

// class AppServices{
//   final MyHttpClient _client;
//   AppServices(this._client);
  
//   Future<ClubBookingList> getTodayBooking(String clubId, String date) async{
//     try{
//       final response = await _client.getRequest('/booking/v1/clubBookingList', params: {
//         'club': clubId,
//         'date': date
//       });
//       final data = ClubBookingList.fromJson(response);
//       return data;
//     }catch(_){
//       rethrow;
//     }
//   }

//   //Define all get or post request in this class


// }