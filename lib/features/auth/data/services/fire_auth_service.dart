import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthServiceProvider = Provider((ref) => FirebaseAuthenticate());

class FirebaseAuthenticate {
  FirebaseAuthenticate() {
    _auth = FirebaseAuth.instance;
  }

  late FirebaseAuth _auth;

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  User? geCurrentUser() => _auth.currentUser;

  String get uid => _auth.currentUser?.uid ?? '';

  //------------------------------New Registration  ----------------------------------------
  Future<UserCredential> registerUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw ('The password provided is weak.');
      } else if (e.code == 'email-already-in-use') {
        throw ('The account already exists for this email.');
      } else {
        throw e.code;
      }
    } catch (_) {
      rethrow;
    }
  }

  //-------------------------------------- Login for excisting Users ---------------------------------------
  Future<UserCredential?> loginUsingEmailAndPassword({
    required String email,
    required String password,
    /* required BuildContext context */
  }) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      final user = _auth.currentUser;
      final userIdToken = await user?.getIdTokenResult(true);
      String roleName = "";
      UserCredential? result;

      if (userIdToken?.claims?['role'].length >= 2) {
        for (var i = 0; i < userIdToken?.claims?['role'].length - 1; i++) {
          String roleValue = userIdToken?.claims?['role'][i];
          if (roleValue == "concierge" || roleValue == "manager") {
            roleName = roleValue;
          }
        }
      } else {
        roleName = userIdToken?.claims?['role'][0];
      }

      //--------------checking the role ----------------
      if (roleName == "concierge" || roleName == "manager") {
        String? clubId = await userIdToken?.claims?["club_id"];
        if (clubId != null) {
          result = credential;
        } else {
          await _auth.signOut();
          result = null;
        }
      } else {
        await _auth.signOut();
        result = null;
      }
      return result;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw ('The password provided is weak.');
      } else if (e.code == 'email-already-in-use') {
        throw ('The account already exists for this email.');
      } else if (e.code == 'wrong-password') {
        throw ('Password entered is incorrect');
      } else if (e.code == "type 'Null' is not a subtype of type 'String'") {
        throw ('This account have no access');
      } else {
        throw e.code;
      }
    } catch (e) {
      if (e.toString() == "type 'Null' is not a subtype of type 'String'") {
        throw ('This account have no access');
      } else {
        throw e.toString();
      }
    }
  }

//-------------------------------------- Log out from the app -------------------------------------
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> resetPasswordEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw e.message.toString();
    } catch (_) {
      rethrow;
    }
  }

//---------------------------------------------- Update/ reset Password --------------------------------------------
  Future<void> updatePassword(
      String currentPassword, String newPassword) async {
    try {
      final cred = EmailAuthProvider.credential(
          email: _auth.currentUser!.email!, password: currentPassword);

      await _auth.currentUser!.reauthenticateWithCredential(cred);

      await _auth.currentUser!.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message ?? e.code);
      throw e.message.toString();
    } catch (_) {
      rethrow;
    }
  }

//---------------------------------------------- Update/ Reset Email ------------------------------
  Future<void> updateEmail(String newEmail) async {
    try {
      final user = _auth.currentUser;

      await user!.updateEmail(newEmail);
    } on FirebaseAuthException catch (e) {
      throw e.message.toString();
    } catch (e) {
      rethrow;
    }
  }
}

//----------------------------------------------------------------------------------

class Resource {
  final Status status;
  Resource({required this.status});
}

enum Status { success, error, cancelled }

//-----------------------------user claims ---------------------------------------


