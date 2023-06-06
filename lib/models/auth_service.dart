import 'package:firebase_auth/firebase_auth.dart';

class CustomError implements Exception {
  final String message;

  CustomError(this.message);
}

class AuthService {
  Future<CustomError?> registration({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return CustomError('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return CustomError('The account already exists for that email.');
      } else {
        return CustomError(e.message ?? 'Something bad happened');
      }
    } catch (e) {
      return CustomError(e.toString());
    }
  }

  Future<CustomError?> login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return CustomError('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return CustomError('Wrong password provided for that user.');
      } else {
        return CustomError(e.message ?? 'Something bad happened');
      }
    } catch (e) {
      return CustomError(e.toString());
    }
  }

  Future<String?> recoverPassword({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );
      return 'An email with password recovery instructions has been sent to your email address.';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }
}
