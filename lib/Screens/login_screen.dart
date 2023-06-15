import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:licenta/Screens/main_screen.dart';
import 'package:licenta/models/auth_service.dart';

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);
  final authService = AuthService();

  Future<String?> _authUser(LoginData data) async {
    final error = await authService.login(
      email: data.name,
      password: data.password,
    );

    return error?.message;
  }

  Future<String?> _signupUser(SignupData data) async {
    final error = await authService.registration(
        email: data.name.toString(), password: data.password.toString());

    return error?.message;
  }

  Future<String?> _recoverPassword(String email) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.sendPasswordResetEmail(email: email);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
        title: 'Finance',
        onLogin: _authUser,
        onSignup: _signupUser,
        onSubmitAnimationCompleted: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
        },
        onRecoverPassword: _recoverPassword,
        theme: LoginTheme(
          primaryColor: Color(0xffd5c8c5),
          accentColor: Color(0xffd5c3eb),
          errorColor: Colors.deepOrange,
          titleStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 55,
            color: Color.fromARGB(255, 54, 54, 54),
          ),
        ));
  }
}
