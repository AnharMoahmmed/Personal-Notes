import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService._();
  static User? get user => _auth.currentUser;
  static final _auth = FirebaseAuth.instance;
  static Stream<User?> get userStream => _auth.userChanges();
  // static bool get isEmailVerfied => user?.emailVerified ?? false;

  static Future<void> register({
    required String fullname,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((credentioal) {
            credentioal.user?.sendEmailVerification();
            credentioal.user?.updateDisplayName(fullname);
          });
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> logout() => _auth.signOut();
  static Future<void> resetPassword({required String email}) => _auth.sendPasswordResetEmail(email: email);

  static Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }
}
