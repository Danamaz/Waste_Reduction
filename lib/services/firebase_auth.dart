import 'package:firebase_auth/firebase_auth.dart';
import 'package:waste_management/services/database.dart';

class FirebaseAuthService {
  final _auth = FirebaseAuth.instance;

  Future<SignResult?> signUpEmailPassword({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await DatabaseService(uid: credential.user!.uid).updateUserData(
        name: name,
        email: email,
        phone: phone,
      );
      return SignResult(user: credential.user);
    } on FirebaseAuthException catch (e) {
      print('Error in signUpEmailPassword: ${e.message}');
      return SignResult(errorMessage: e.message);
    }
  }

  Future signInEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return SignResult(user: credential.user);
    } on FirebaseAuthException catch (e) {
      print('Error in signUpEmailPassword: ${e.message}');
      return SignResult(errorMessage: e.message);
    }
  }
}

class SignResult {
  final User? user;
  final String? errorMessage;

  SignResult({this.user, this.errorMessage});
}
