import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:licenta/Screens/login_screen.dart';
import 'package:licenta/widgets/bottom_navigation_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD8F3F3),
      appBar: AppBar(
        elevation: 0,
        title: Center(
            child:
                const Text('Profile', style: TextStyle(color: Colors.black))),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffD8F3F3),
      ),
      bottomNavigationBar: const CustomNavigationBar(selectedIndex: 2),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text(
              'Hello ${FirebaseAuth.instance.currentUser?.email ?? ""}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: SizedBox(
                  height: 70,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: _showResetEmailConfirmationDialog,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.black,
                    ),
                    child: const Text(
                      'Reset Password',
                      style: TextStyle(fontSize: 17),
                    ),
                  )),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: SizedBox(
                  height: 70,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () async {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                          (route) => false);
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.white10),
                    child: const Text(
                      'Log Out',
                      style: TextStyle(fontSize: 17),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  _resetPassword() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    String? email = user?.email;

    if (user != null && email != null) {
      await auth.sendPasswordResetEmail(email: email);
    }
  }

  _showResetEmailConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Send password reset email?'),
          actions: [
            TextButton(
              child: const Text(
                'No',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.blueAccent),
              ),
              onPressed: () {
                _resetPassword();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
