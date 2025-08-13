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
    // notifyListeners();
  }

  String get fullname => _fullname.trim();

  String _email = '';
  set email(String value) {
    _email = value;
    // notifyListeners();
  }

  String get email => _email.trim();

  String _password = '';
  set password(String value) {
    _password = value;
    // notifyListeners();
  }

  String get password => _password;

  bool _isLoading = false;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  Future<void> authenticateWithEamilAndPassword({
    required BuildContext context,
  }) async {
    isLoading = true;

    try {
      if (_isRegisterMode) {
        await AuthService.register(
          fullname: fullname,
          email: email,
          password: password,
        );
        if (!context.mounted) return;

        ShowMessageDialog(
          context: context,
          Message:
              'A verifaction email was sent to the provided email adress. please confirm your email to produce to the app ',
        );

        //reload the user
        // while (!AuthService.isEmailVerfied) {
        // await  Future.delayed(
        //     Duration(seconds: 5),
        //     () => AuthService.user?.reload(),
        //   );
        // }
      } else {
        //sign in the user
        await AuthService.login(email: email, password: password);
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
    } finally {
      isLoading = false;
    }
  }

  Future<void> resetPassword({
    required BuildContext context,
    required String email,
  }) async {
    isLoading = true;
    try {
      await AuthService.resetPassword(email: email);
      if (!context.mounted) return;
      ShowMessageDialog(
        context: context,
        Message:
            ' A Reset Password linke has sent to your email adress: $email open the like to rest password ',
      );
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      ShowMessageDialog(
        context: context,
        Message: authExceptionMapper[e.code] ?? 'An knowen error accoured!',
      );
    } catch (e) {
      if (!context.mounted) return;

      ShowMessageDialog(context: context, Message: 'An knowen error accoured!');
    } finally {
      isLoading = false;
    }
  }
}
