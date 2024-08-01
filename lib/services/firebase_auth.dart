import 'package:firebase_auth/firebase_auth.dart';
import 'package:waste_management/services/database.dart';

class FirebaseAuthService {
  final _auth = FirebaseAuth.instance;

  Future<User?> signUpEmailPassword({
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
      return credential.user;
    } catch (e) {
      print('Error in signUpEmailPassword: $e');
      return null;
    }
  }

  Future<User?> signInEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      print('Error in signInEmailPassword: ${e.toString()}');
      return null;
    }
  }
}
