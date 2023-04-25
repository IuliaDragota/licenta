import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:licenta/Screens/main_screen.dart';
import 'package:licenta/Screens/profile_screen.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffd5c8c5),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.query_stats_outlined), label: 'Statistics'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFFB494DB),
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => HomeScreen()),
              );

              break;
            case 1:
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => StatisticsScreen()),
              );

              break;
            case 2:
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => ProfileScreen()),
              );

              break;
          }
          setState(
            () {
              _selectedIndex = index;
            },
          );
        },
      ),
    );
  }
}
