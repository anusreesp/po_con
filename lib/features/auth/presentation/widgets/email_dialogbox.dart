import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_concierge/features/auth/controllers/forgetpassword_controller.dart';
import 'package:htp_concierge/features/auth/data/services/validation.dart';
import 'custom_material_button.dart';
import '../../../dashboard/presentation/widgets/dialog_box.dart';

final emailProvider = Provider((ref) {
  return EmailDialogBox();
});

class EmailDialogBox {
  emailTextPopup(
    BuildContext context,
    Validate validationProvider,
    // WidgetRef ref,
  ) {
    final emailController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    sendButton() {
      return Consumer(builder: (context, ref, _) {
        final controller = ref.watch(forgetPasswordProvider);

        ref.listen(forgetPasswordProvider, (previous, next) {
          if (next is ForgetPasswordErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(next.msg)));
          }

          if (next is ForgetPasswordLinkSentState) {
            Navigator.pop(context);

            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  // startTimefun();
                  return ref.read(dialogBoxProvider).confirmationPopup(
                      context,
                      "done.png",
                      "Request Sent",
                      "Please check your email to reset your password",
                      true);
                });
          }
        });
        if (controller is ForgetLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // child:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: CustomButton(
            height: 40,
            width: double.infinity,
            onTap: () async {
              if (formKey.currentState?.validate() ?? false) {
                var emailTrimed = emailController.text.trim();
                ref
                    .read(forgetPasswordProvider.notifier)
                    .sentEmailResetLink(emailTrimed);

                await Future.delayed(const Duration(seconds: 1));
              }
            },
            child: const Text(
              'SEND',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        );
      });
    }

    return Dialog(
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        elevation: 10,
        child: Form(
          key: formKey,
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black,
                  border: Border.all(
                      color: Colors.yellow.withOpacity(0.4), width: 0.7)),
              height: 220,
              child: Column(children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.grey,
                      )),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Enter your email or concierge id',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 13.0,
                ),
                SizedBox(
                  height: 40,
                  width: 280,
                  child: TextFormField(
                    enableInteractiveSelection: true,
                    // onChanged: (value) {},
                    validator: (val) {
                      val = val?.trim();
                      return validationProvider.validateEmail(email: val);
                    },
                    controller: emailController,

                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 14.0),
                        hintText: "mike@gmail.com",
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(
                                color:
                                    const Color(0xffC6C6C6).withOpacity(0.8))),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide:
                              BorderSide(color: Colors.white.withOpacity(0.6)),
                        )),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                //---------------------------send Button -------------------------
                sendButton()
              ])),
        ));
  }
}
