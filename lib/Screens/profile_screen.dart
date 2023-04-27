import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:licenta/Screens/main_screen.dart';
import 'package:licenta/Screens/statistics_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('profile', style: TextStyle(color: Colors.black)),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffE6DEF0),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
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
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text('Hello Iulia')),
            SizedBox(
              height: 50,
            ),
            Center(
              child: SizedBox(
                  height: 70,
                  width: 300,
                  child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Edit',
                        style: TextStyle(color: Colors.black, fontSize: 25),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xffE6DEF0)))),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: SizedBox(
                  height: 70,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Logout'),
                    style: ElevatedButton.styleFrom(primary: Color(0xFFc1dedc)),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
