import 'package:flutter_riverpod/flutter_riverpod.dart';

final validateProvider = Provider((ref) => Validate());

class Validate {
  String? validateEmail({required String? email}) {
    if (email == null) {
      return null;
    }

    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.isEmpty) {
      return 'Email can\'t be empty';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Enter a correct email';
    }

    return null;
  }

  String? validatePassword({required String? password}) {
    if (password == null) {
      return null;
    }

    if (password.isEmpty) {
      return 'Password can\'t be empty';
    } else if (password.length < 6) {
      return 'Enter a password with length at least 6';
    }

    return null;
  }

  String? validateConfirmPassword(
      {required String? password, required String? confirmPassword}) {
    if (confirmPassword == null) {
      return null;
    }

    if (confirmPassword.isEmpty) {
      return 'Password can\'t be empty';
    } else if (confirmPassword.length < 6) {
      return 'Enter a password with length at least 6';
    }
    if (confirmPassword != password) {
      return 'Not Match with new Password';
    }
    return null;
  }
}
