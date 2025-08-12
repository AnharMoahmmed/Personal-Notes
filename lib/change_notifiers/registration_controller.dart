import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:personal_notes/core/constans.dart';
import 'package:personal_notes/core/dialogs.dart';
import 'package:personal_notes/services/auth_service.dart';

class RegistrationController extends ChangeNotifier {
  bool _isRegisterMode = true;
  bool get isRegisterMode => _isRegisterMode;

  set isRegisterMode(bool value) {
    _isRegisterMode = value;
    notifyListeners();
  }

  bool _isPasswordHidden = true;
  bool get isPasswordHidden => _isPasswordHidden;

  set isPasswordHidden(bool value) {
    _isPasswordHidden = value;
    notifyListeners();
  }

  String _fullname = '';
  set fullname(String value) {
    _fullname = value;
    notifyListeners();
  }

  String get fullname => _fullname.trim();

  String _email = '';
  set email(String value) {
    _email = value;
    notifyListeners();
  }

  String get email => _email.trim();

  String _password = '';
  set password(String value) {
    _password = value;
    notifyListeners();
  }

  String get password => _password;

  Future<void> authenticateWithEamilAndPassword({
    required BuildContext context,
  }) async {
    try {
      if (_isRegisterMode) {
        await AuthService.register(
          fullname: fullname,
          email: email,
          password: password,
        );
      } else {
        //sign in the user
      }
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      ShowMessageDialog(
        context: context,
        Message: authExceptionMapper[e.code] ?? 'An knowen error accoured!',
      );
    } catch (e) {
      if (!context.mounted) return;

      ShowMessageDialog(context: context, Message: 'An knowen error accoured!');
    }
  }
}
