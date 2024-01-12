// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../custom_material_button.dart';
// import '../../../../dashboard/presentation/widgets/dialog_box.dart';
// import '../../../controllers/profile/reset_email_controller.dart';
// import '../../../controllers/update_credential_controllers.dart';
// import '../../../data/services/fire_auth_service.dart';
// import '../../../data/services/validation.dart';
// import '../../screens/update_profile.dart';
// import '../custom_text_field.dart';

// class EditEmailField extends StatefulWidget {
//   const EditEmailField({Key? key}) : super(key: key);

//   @override
//   State<EditEmailField> createState() => _EditEmailField();
// }

// class _EditEmailField extends State<EditEmailField> {
//   GlobalKey<FormState> emailFormKey = GlobalKey();
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer(
//         builder: (BuildContext context, WidgetRef ref, Widget? child) {
//       final editEmail = ref.watch(editEmailProvider);

//       final fireAuthController = ref.watch(firebaseAuthServiceProvider);

//       final user = fireAuthController.geCurrentUser();

//       if (editEmail) {
//         return Form(
//           key: emailFormKey,
//           child: Column(
//             //mainAxisAlignment: MainAxisAlignment.end,
//             crossAxisAlignment: CrossAxisAlignment.start,

//             children: [
//               const Text('Email'),
//               const SizedBox(
//                 height: 10,
//               ),
//               SizedBox(
//                 width: MediaQuery.of(context).size.width * 0.82,
//                 child: CustomTextField(
//                   hintText: "mike@g",
//                   onValidate: (val) {
//                     val = val?.trim();
//                     return ref.read(validateProvider).validateEmail(email: val);
//                   },
//                   onChanged: (value) {
//                     ref.read(updateEmailProvider.notifier).state = value;
//                   },
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 //crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   const SizedBox(
//                     width: 150,
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       ref.read(editEmailProvider.notifier).state = false;
//                     },
//                     child: const SizedBox(
//                       height: 50,
//                       child: Text(
//                         'Cancel',
//                         style: TextStyle(
//                             fontSize: 16,
//                             color: Color(0xffFFFFFF),
//                             decoration: TextDecoration.underline,
//                             decorationColor: Color(0xffFFFFFF)),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 20,
//                   ),
//                   Padding(
//                       padding: const EdgeInsets.only(bottom: 30),
//                       child: Consumer(builder: (context, ref, _) {
//                         final emailController = ref.watch(resetEmailProvider);

//                         ref.listen(resetEmailProvider, (previous, next) {
//                           if (next is ResetEmailErrorState) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(content: Text(next.msg)));
//                           }
//                           if (next is ResetEmailLinkSentState) {
//                             showDialog(
//                                 builder: (BuildContext context) {
//                                   return ref
//                                       .read(dialogBoxProvider)
//                                       .confirmationPopup(
//                                           context,
//                                           "done.png",
//                                           "Email Updated",
//                                           "Email updated successfully",
//                                           true);
//                                 },
//                                 context: context);
//                           }
//                         });
//                         if (emailController is ResetEmailLoading) {
//                           return const Center(
//                             child: CircularProgressIndicator(),
//                           );
//                         }

//                         return CustomButton(
//                           onTap: () {
//                             if (emailFormKey.currentState?.validate() ??
//                                 false) {
//                               ref
//                                   .read(resetEmailProvider.notifier)
//                                   .updateEmail(ref.watch(updateEmailProvider));
//                               ref.read(editEmailProvider.notifier).state =
//                                   false;
//                             }
//                           },
//                           height: 30,
//                           width: 101,
//                           child: const Text(
//                             'Update',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(color: Colors.black),
//                           ),
//                         );
//                       }))
//                 ],
//               ),
//             ],
//           ),
//         );
//       } else {
//         return Cred(
//           text: 'Email',
//           enterDetails: Text(
//             user?.email ?? 'mike@gmail.com',
//             style: const TextStyle(fontSize: 9, color: Colors.grey),
//           ),
//           onTap: () {
//             ref.read(editPasswordProvider.notifier).state = false;
//             ref.read(editEmailProvider.notifier).state = true;
//           },
//           canEdit:
//               false, //----------------------------------------- Edit option is false
//         );
//       }
//     });
//   }
// }
