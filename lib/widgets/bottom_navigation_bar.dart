import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:licenta/Screens/profile_screen.dart';
import 'package:licenta/Screens/statistics_screen.dart';
import 'package:licenta/screens/main_screen.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key, required this.selectedIndex});
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.query_stats_outlined), label: 'Statistics'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined), label: 'Profile'),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: const Color(0xFFB494DB),
      onTap: (int index) {
        switch (index) {
          case 0:
            Navigator.pushAndRemoveUntil(
              context,
              PageRouteBuilder(
                transitionDuration: Duration.zero,
                pageBuilder: (_, __, ___) => HomeScreen(),
              ),
              (route) => false,
            );
            break;
          case 1:
            Navigator.pushAndRemoveUntil(
              context,
              PageRouteBuilder(
                transitionDuration: Duration.zero,
                pageBuilder: (_, __, ___) => const StatisticsScreen(),
              ),
              (route) => false,
            );
            break;
          case 2:
            Navigator.pushAndRemoveUntil(
              context,
              PageRouteBuilder(
                transitionDuration: Duration.zero,
                pageBuilder: (_, __, ___) => const ProfileScreen(),
              ),
              (route) => false,
            );
            break;
        }
      },
    );
  }
}
