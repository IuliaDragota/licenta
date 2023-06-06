import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:licenta/Screens/login_screen.dart';
import 'package:licenta/Screens/main_screen.dart';
import 'package:licenta/Screens/statistics_screen.dart';
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
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(color: Colors.black)),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffE6DEF0),
      ),
      bottomNavigationBar: const CustomNavigationBar(selectedIndex: 2),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text('Hello ${FirebaseAuth.instance.currentUser?.email ?? ""}')),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: SizedBox(
                  height: 70,
                  width: 300,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0xffE6DEF0)),
                      child: const Text(
                        'Edit',
                        style: TextStyle(color: Colors.black, fontSize: 25),
                      ))),
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
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(
                          builder: (context) => LoginScreen()), (route) => false);
                    },
                    style: ElevatedButton.styleFrom(primary: const Color(0xFFc1dedc)),
                    child: const Text('Logout'),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
