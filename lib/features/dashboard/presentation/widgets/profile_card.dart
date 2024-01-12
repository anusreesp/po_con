import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:htp_concierge/features/auth/controllers/auth_controller.dart';
import 'package:htp_concierge/features/auth/data/services/fire_auth_service.dart';
import 'package:htp_concierge/features/auth/presentation/screens/login_screen.dart';
import 'package:htp_concierge/features/dashboard/data/services/firebase_services.dart';

final profileProvider =
    FutureProvider.autoDispose<Map<String, dynamic>?>((ref) async {
  User? user;
  final authController = ref.watch(authProvider);
  await Future.delayed(const Duration(seconds: 2));
  if (authController is AuthLoggedInState) {
    user = authController.user;
  } else if (authController is AuthLoadingState) {
    Future.delayed(const Duration(seconds: 2));
  } else {
    user = FirebaseAuth.instance.currentUser;
  }
  final idTokenResult = await user?.getIdTokenResult(true);

  String clubId = await idTokenResult?.claims?["club_id"];

  final details = await FireServices().clubDetails(clubId);

  return await FireServices().clubDetails(clubId);
});

// ignore: must_be_immutable
class ProfileCard extends ConsumerWidget {
  Widget child;

  ProfileCard({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(profileProvider);
    final user = ref.watch(firebaseAuthServiceProvider).geCurrentUser();

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
              height: MediaQuery.of(context).size.height * 0.13,
              //width: 350,
              padding: const EdgeInsets.only(left: 25.0),
              decoration: const BoxDecoration(
                color: Color(0xff000000),

                //borderRadius: BorderRadius.circular(10),
              ),
              child: controller.when(data: (data) {
                if (data == null) {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    ref.read(firebaseAuthServiceProvider).signOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  });

                  return SizedBox();
                }
                return Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            // width: 180,

                            child: Text(
                              data?['name'],
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(
                            height: 4.0,
                          ),
                          SizedBox(
                            // width: 170,
                            height: 20,
                            child: Text(
                              user?.email ?? /* Enter your email or  */
                                  'user emailid',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    //----------------------------------club Logo will be here instead ----------------
                    // data['logo'].when(data
                    data?['logo'] != null
                        ? Image(
                            height: double.infinity,
                            width: MediaQuery.of(context).size.width * 0.29,
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              data?['logo'],
                            ))
                        : SvgPicture.asset(
                            'assets/svgimages/nologo.svg',
                            // width: 120,
                            width: MediaQuery.of(context).size.width * 0.29,
                            fit: BoxFit.cover,
                            // height: double.infinity,
                          ),
                  ],
                );
              }, error: (error, stack) {
                return const Text('Something went wrong...!');
              }, loading: () {
                return const Center(child: CircularProgressIndicator());
              })),
        ),
        Positioned(
          bottom: 3,
          right: 5,
          child: child,
        ),
      ],
    );
  }
}
