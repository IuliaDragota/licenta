// import 'package:flutter/material.dart';
// import 'package:licenta/Screens/main_screen.dart';
// import 'package:licenta/models/auth_service.dart';
// import 'package:licenta/models/create_account.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);

//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffd5c8c5),
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: const Text('Login'),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Card(
//                   color: Color(0xffd5c8c5),
//                   elevation: 10,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(10))),
//                   margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
//                   child: Padding(
//                     padding: EdgeInsets.all(10.0),
//                     child: Container(
//                       height: 200,
//                       width: 400,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           TextField(
//                             controller: _emailController,
//                             decoration: const InputDecoration(
//                                 hintText: 'Email',
//                                 hintStyle: TextStyle(color: Colors.black)),
//                           ),
//                           const SizedBox(
//                             height: 30.0,
//                           ),
//                           TextField(
//                             controller: _passwordController,
//                             obscureText: true,
//                             decoration: const InputDecoration(
//                                 hintText: 'Password',
//                                 hintStyle: TextStyle(color: Colors.black)),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () async {
//                     final message = await AuthService().login(
//                       email: _emailController.text,
//                       password: _passwordController.text,
//                     );
//                     if (message!.contains('Success')) {
//                       Navigator.of(context).pushReplacement(
//                         MaterialPageRoute(
//                           builder: (context) => HomeScreen(),
//                         ),
//                       );
//                     }
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text(message),
//                       ),
//                     );
//                   },
//                   child: Text(
//                     'Login',
//                     style: TextStyle(fontSize: 17),
//                   ),
//                   style: ButtonStyle(
//                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                       RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                     ),
//                     minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
//                     backgroundColor: MaterialStateProperty.all<Color>(Colors
//                         .black), // Setează culoarea de fundal a butonului la negru
//                     foregroundColor: MaterialStateProperty.all<Color>(Colors
//                         .white), // Setează culoarea textului butonului la alb
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => const CreateAccount(),
//                       ),
//                     );
//                   },
//                   child: Text(
//                     'Create Account',
//                     style: TextStyle(
//                         fontSize: 17,
//                         color: Colors
//                             .black), // Setează culoarea textului butonului la negru
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:licenta/Screens/main_screen.dart';
import 'package:licenta/models/auth_service.dart';

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);
  final authService = AuthService();

  Future<String?> _authUser(LoginData data) async {
    debugPrint('Name: ${data.name}, Password: ${data.password}');

    final error = await authService.login(
      email: data.name,
      password: data.password,
    );

    return error?.message;
  }

  Future<String?> _signupUser(SignupData data) async {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    
    final error =  await authService.registration(
        email: data.name.toString(),
        password: data.password.toString()
    );

    return error?.message;
  }

  Future<String> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return '';
    });
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
            fontSize: 55,
            color: Color.fromARGB(255, 54, 54, 54),
          ),
        ));
  }
}
