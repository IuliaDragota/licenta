import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:licenta/Screens/main_screen.dart';
import 'package:licenta/Screens/profile_screen.dart';
import 'package:pie_chart/pie_chart.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  int _selectedIndex = 1;

  Map<String, double> dataMap = {
    "Food": 5,
    "Entertainment": 3,
    "Housing": 2,
    "Other": 2,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Statistics',
          style: TextStyle(color: Colors.black),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffE6DEF0),
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
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            PieChart(
              dataMap: dataMap,
              chartType: ChartType.ring,
              colorList: [
                Color(0xFFc1dedc),
                Color(0xFFF1DECA),
                Color(0xFFe6def0),
                Color(0xFFB9A9BD),
              ],
            ),
            SizedBox(height: 90),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 170,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Food', style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(primary: Color(0xFFc1dedc)),
                  ),
                ),
                SizedBox(
                  width: 170,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Entertainment',
                        style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(primary: Color(0xffE6DEF0)),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 170,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {},
                    child:
                        Text('Housing', style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(primary: Color(0xffE6DEF0)),
                  ),
                ),
                SizedBox(
                  width: 170,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Other', style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(primary: Color(0xFFc1dedc)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),

      // gradientList: ---To add gradient colors---
      // emptyColorGradient: ---Empty Color gradient---
    );
  }
}
