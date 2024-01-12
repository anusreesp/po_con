// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:htp_concierge/features/dashboard/data/services/firebase_services.dart';

// final fireDbServiceProvider =
//     StateNotifierProvider<FireDbServiceController, FireDbServiceState>((ref) {
//   final fire = ref.watch(firebasedbProvider);
//   return FireDbServiceController(fire);
// });

// class FireDbServiceController extends StateNotifier<FireDbServiceState> {
//   final FireServices _fire;
//   FireDbServiceController(this._fire) : super(FireDbServiceInitialState());

//   getFirebaseDetails(DateTime selectedData) async {
//     try {
//       state = FirebaseDbServiceLoading();

//       await _fire.getFirebaseDetails(selectedData);

//       state = FirebaseDbServiceDoneState();
//     } catch (e) {
//       state = FirebaseDbServiceErrorState(e.toString());
//     }
//   }
// }

// abstract class FireDbServiceState {}

// class FireDbServiceInitialState extends FireDbServiceState {}

// class FirebaseDbServiceLoading extends FireDbServiceState {}

// class FirebaseDbServiceDoneState extends FireDbServiceState {}

// class FirebaseDbServiceErrorState extends FireDbServiceState {
//   final String msg;
//   FirebaseDbServiceErrorState(this.msg);
// }
