import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../custom_material_button.dart';
import '../../../../dashboard/presentation/widgets/dialog_box.dart';
import '../../../controllers/profile/reset_password_controller.dart';
import '../../../controllers/update_credential_controllers.dart';
import '../../../data/services/validation.dart';
import '../../screens/update_profile.dart';
import '../custom_password_field.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  // static final formKey = GlobalKey<FormState>();

  @override
  State<ResetPassword> createState() => _ResetPassword();
}

class _ResetPassword extends State<ResetPassword> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String currentPassword = "";
  String newPassword = "";
  String confirmPassword = "";
  dynamic formKey;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(
    BuildContext context,
    /* WidgetRef ref */
  ) {
    return Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
      final editPassword = ref.watch(editPasswordProvider);
      final validationProvider = ref.read(validateProvider);
      if (editPassword) {
        return Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.only(right: 28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Password'),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 38.0,
                  child: CustomPasswordField(
                    controller: _currentPasswordController,
                    hintText: "Enter Current Password",
                    onValidate: (val) =>
                        validationProvider.validatePassword(password: val),
                    onChanged: (val) {
                      ref.read(currentPasswordProvider.notifier).state = val;
                    },
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  height: 38.0,
                  child: CustomPasswordField(
                      controller: _newPasswordController,
                      hintText: "Enter New Password",
                      onValidate: (value) {
                        return validationProvider.validatePassword(
                            password: value);
                      },
                      onChanged: (value) {
                        ref.read(newPasswordProvider.notifier).state = value;
                      }),
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                    height: 38.0,
                    child: CustomPasswordField(
                        controller: _confirmPasswordController,
                        hintText: "Confirm New Password",
                        onValidate: (value) {
                          final newPasssword = ref.watch(newPasswordProvider);
                          final confirmPassword =
                              ref.watch(confirmPasswordProvider);
                          return validationProvider.validateConfirmPassword(
                              password: newPasssword,
                              confirmPassword: confirmPassword);
                        },
                        onChanged: (val) {
                          ref.read(confirmPasswordProvider.notifier).state =
                              val;
                        })),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        ref.read(editPasswordProvider.notifier).state = false;
                      },
                      child: const SizedBox(
                        height: 50,
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xffFFFFFF),
                              decoration: TextDecoration.underline,
                              decorationColor: Color(0xffFFFFFF)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: Consumer(
                          builder: (context, ref, _) {
                            // final authStateChanges =
                            //     ref.watch(updatePasswordProvider);

                            final controller = ref.watch(resetPasswordProvider);
                            ref.listen(resetPasswordProvider, (previous, next) {
                              if (next is ResetPasswordErrorState) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(next.msg)));
                              }

                              if (next is ResetPasswordDoneState) {
                                showDialog(
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return ref
                                          .read(dialogBoxProvider)
                                          .confirmationPopup(
                                              context,
                                              "done.png",
                                              "Password Updated",
                                              "Password updated successfully",
                                              true);
                                    },
                                    context: context);
                                ref.read(editPasswordProvider.notifier).state =
                                    false;
                              }
                            });

                            if (controller is ResetPasswordLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                                // ),
                              );
                            }

                            return CustomButton(
                              height: 30,
                              width: 101,
                              onTap: () async {
                                currentPassword =
                                    ref.watch(currentPasswordProvider);
                                newPassword = ref.watch(newPasswordProvider);
                                if (formKey.currentState?.validate() ?? false) {
                                  ref
                                      .read(resetPasswordProvider.notifier)
                                      .updatePassword(
                                          currentPassword, newPassword);
                                  await Future.delayed(
                                      const Duration(seconds: 1));

                                  _currentPasswordController.clear();
                                  _newPasswordController.clear();
                                  _confirmPasswordController.clear();
                                }
                              },
                              child: const Text(
                                'Update',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            );
                          },
                        ))
                  ],
                ),
              ],
            ),
          ),
        );
      } else {
        return Cred(
          text: 'Password',
          enterDetails: Row(
            children: [
              ...List.generate(
                  8,
                  (index) => const Padding(
                        padding: EdgeInsets.all(3.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 3,
                        ),
                      ))
            ],
          ),
          onTap: () {
            ref.read(editPasswordProvider.notifier).state = true;
            ref.read(editEmailProvider.notifier).state = false;
          },
        );
      }
    });
  }
}
