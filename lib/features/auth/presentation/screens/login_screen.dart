import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_concierge/features/auth/controllers/auth_controller.dart';
import 'package:htp_concierge/features/auth/data/services/validation.dart';
import 'package:htp_concierge/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:htp_concierge/features/auth/presentation/widgets/custom_material_button.dart';
import '../../../../dashboard.dart';
import '../../../../global_providers.dart';

import '../widgets/email_dialogbox.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceHeight = MediaQuery.of(context).size.height;
    // final deviceWidth = MediaQuery.of(context).size.width;
    final validationProvider = ref.read(validateProvider);

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: GestureDetector(
        onTap: () {
          _focusEmail.unfocus();
          _focusPassword.unfocus();
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: deviceHeight,
              decoration: const BoxDecoration(color: Color(0xff171717)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          // alignment: Alignment.topLeft,

                          padding: const EdgeInsets.only(
                            top: 150,
                          ),
                          child: const Text(
                            'Login to Concierge app',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      const Text(
                        'Enter your email or concierge id',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 13.0,
                      ),

                      //---------------------Email----------------
                      CustomTextField(
                          hintText: "Email",
                          controller: _emailController,
                          focusNode: _focusEmail,
                          onValidate: (val) {
                            val = val?.trim();
                            return validationProvider.validateEmail(email: val);
                          }),
                      const SizedBox(
                        height: 19,
                      ),
                      const Text(
                        'Password',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      //----------------Password---------------------
                      CustomTextField(
                        hintText: "Password",
                        controller: _passwordController,
                        focusNode: _focusPassword,
                        obscureText: true,
                        onValidate: (val) =>
                            validationProvider.validatePassword(password: val),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const TroubleLogin(),
                      const Spacer(),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 30.0),
                          child: Consumer(
                            builder: (context, ref, _) {
                              final authStateChanges =
                                  ref.watch(authStateChangeProvider);

                              if (authStateChanges.isLoading) {
                                return const SizedBox(
                                  height: 50,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }

                              final loginController = ref.read(authProvider);

                              if (loginController is AuthLoadingState) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              return CustomButton(
                                height: 50,
                                width: double.infinity,
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    var emailTrimed =
                                        _emailController.text.trim();
                                    final userCred = await ref
                                        .read(authProvider.notifier)
                                        .userLogin(
                                            emailTrimed,
                                            // _emailController.text,
                                            _passwordController.text);

                                    if (userCred != null) {
                                      if (context.mounted) {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Dashboard()));
                                      }
                                    }
                                  }
                                },
                                child: const Text(
                                  'LOGIN',
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
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TroubleLogin extends StatelessWidget {
  const TroubleLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Trouble logging in ? ',
            style: TextStyle(
              color: Color(0xffF2F2F2),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Consumer(builder: (context, ref, _) {
            final validationProvider = ref.read(validateProvider);
            return GestureDetector(
              onTap: () async {
                return showDialog(
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return ref.read(emailProvider).emailTextPopup(
                            context,
                            validationProvider,
                          );
                    },
                    context: context);
              },
              child: const Text(
                'Contact Party One support',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    // decorationStyle: TextDecorationStyle.double,
                    color: Color(0xffF2F2F2)),
              ),
            );
          }),
        ],
      ),
    );
  }
}
