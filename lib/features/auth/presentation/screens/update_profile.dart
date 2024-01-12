import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_concierge/features/auth/presentation/screens/login_screen.dart';
import 'package:htp_concierge/features/dashboard/controller/widget_controller/search_controller.dart';
import 'package:htp_concierge/features/dashboard/controller/widget_controller/sort_controller.dart';
import 'package:htp_concierge/features/dashboard/presentation/widgets/fresh_chat.dart';
import '../../../dashboard/controller/widget_controller/tab_controller.dart';
import '../../../dashboard/presentation/widgets/profile_card.dart';
import '../../data/services/fire_auth_service.dart';
import '../widgets/update_profile/reset_password.dart';

class UpdateProfile extends ConsumerWidget {
  const UpdateProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: const Color(0xff171717),
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Color(0xffFFFFFF),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          title: const Text(
            "Profile",
            style: TextStyle(
                color: Color(0xffFFFFFF),
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleSpacing: 1,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileCard(
                  child: Container(),
                ),
                const SizedBox(
                  height: 10.0,
                ),

                //---------------------------CredentialForm---------------------------------
                const CredentialForm(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                ),
                Center(
                    child: MaterialButton(
                  onPressed: () {
                    ref.read(sortProvider.notifier).state = "";
                    ref.watch(nameSearchProvider.notifier).state = "";
                    ref.read(membershipSortProvider.notifier).state = [];
                    ref.read(tabController.notifier).state = GuestTab.all;
                    ref.read(firebaseAuthServiceProvider).signOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Ink(
                      width: 116,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                              color: const Color.fromARGB(255, 226, 226, 226))),
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "LOGOUT",
                          style: TextStyle(
                              fontFamily: "OpenSans",
                              fontSize: 12,
                              color: Color.fromARGB(255, 218, 218, 218)),
                        ),
                      )),
                )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'For other trouble',
                        style:
                            TextStyle(fontSize: 14, color: Color(0xffFFFFFF)),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: () async {
                          ref.read(freshChatProvider).startChat();
                        },
                        child: const Text(
                          'Contact Party One Support',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffFFFFFF),
                              decoration: TextDecoration.underline),
                        ),
                      )
                    ]),
              ],
            ),
          ),
        ));
  }
}

class CredentialForm extends StatelessWidget {
  const CredentialForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: 460,

        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xff000000)),
        child: const Padding(
            padding: EdgeInsets.only(left: 28, top: 28, bottom: 28),
            child: Row(children: [
              Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ResetPassword(),
                    ]),
              ),
            ])));
  }
}

class Cred extends StatelessWidget {
  final String text;
  final Widget enterDetails;
  final VoidCallback onTap;
  final bool canEdit;

  const Cred(
      {Key? key,
      required this.text,
      required this.enterDetails,
      required this.onTap,
      this.canEdit = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 28),
      child: Row(
        children: [
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style:
                      const TextStyle(fontSize: 12, color: Color(0xffFFFFFF)),
                ),
                const SizedBox(
                  height: 6.4,
                ),
                // Spacer(),
                enterDetails
              ],
            ),
          ),
          const Spacer(),
          canEdit == true
              ? SizedBox(
                  child: GestureDetector(
                      onTap: onTap,
                      child: const Image(
                        image: AssetImage(
                          "assets/images/edit.png.png",
                        ),
                        color: Color(0xffFFFFFF),
                      )),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
