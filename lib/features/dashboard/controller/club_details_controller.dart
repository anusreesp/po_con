// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:htp_concierge/features/auth/controllers/auth_controller.dart';
// import 'package:htp_concierge/features/auth/data/services/fire_auth_service.dart';
// import 'package:htp_concierge/features/dashboard/data/services/firebase_services.dart';

// class ClubDetailsController extends StateNotifier<ClubDetailsStates> {
//   final FireServices _services;
//   final AuthController _auth;
//   final FirebaseAuthenticate fireAuth;
//   ClubDetailsController(this._services, this._auth, this.fireAuth)
//       : super(ClubDetailsInitial()) {
//     clubDetails();
//   }

//   clubDetails() async {
//     state = ClubDetailsLoading();

//     try {
//       final user = FirebaseAuth.instance.currentUser;

//       final idTokenResult = await user?.getIdTokenResult(true);

//       String clubId = await idTokenResult?.claims?["club_id"];

//       final details = _services.clubDetails(clubId);

//       state = ClubDetailsLoaded();
//     } catch (e) {
//       state = ClubDetailsError(e.toString());
//       await FirebaseAuth.instance.signOut();
//       state = ClubDetailsInitial();
//     }
//   }
// }

// abstract class ClubDetailsStates {}

// class ClubDetailsInitial extends ClubDetailsStates {}

// class ClubDetailsLoading extends ClubDetailsStates {}

// class ClubDetailsLoaded extends ClubDetailsStates {}

// class ClubDetailsError extends ClubDetailsStates {
//   final String msg;
//   ClubDetailsError(this.msg);
// }
