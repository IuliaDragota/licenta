import 'package:flutter/material.dart';
import 'package:licenta/Screens/login_screen.dart';
import 'package:licenta/Screens/main_screen.dart';
import 'package:licenta/onboarding_3.dart';

class Onboarding2 extends StatefulWidget {
  const Onboarding2({super.key});

  @override
  State<Onboarding2> createState() => _Onboarding2State();
}

class _Onboarding2State extends State<Onboarding2> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffd5c3eb),
      appBar: AppBar(
        backgroundColor: const Color(0xffd5c3eb),
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Row(
          children: [
            Container(
              height: 6,
              width: size.width / 3 - 18,
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
            ),
            const SizedBox(width: 10),
            Container(
              height: 6,
              width: size.width / 3 - 18,
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
            ),
            const SizedBox(width: 10),
            Container(
              height: 6,
              width: size.width / 3 - 18,
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'Keep your expenses on track',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'You don\'t Have to worry because we got\n what you are looking for ',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 10),
          Image.asset('assets/images/new_onboarding_2.png'),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const Onboarding3(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              ),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                width: size.width,
                height: 50,
                child: const Center(
                    child: Text(
                  'Next',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen())),
              child: SizedBox(
                width: size.width,
                height: 50,
                child: const Center(
                    child: Text(
                  'Skip',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
