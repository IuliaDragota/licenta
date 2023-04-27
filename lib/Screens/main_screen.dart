import 'package:flutter/material.dart';
import 'package:licenta/Screens/Expenses_screen.dart';
import 'package:licenta/Screens/financial_school_screen.dart';
import 'package:licenta/Screens/goals_screen.dart';
import 'package:licenta/Screens/news_home_screen.dart';
import 'package:licenta/Screens/profile_screen.dart';
import 'package:licenta/Screens/statistics_screen.dart';

import 'package:licenta/Screens/transactions_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Overview',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => TransactionsScreen()),
                  );
                },
                child: Card(
                  color: Color(0xFFf0edea),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ClipPath(
                    clipper: ShapeBorderClipper(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Container(
                      height: 200,
                      width: 400,
                      padding: EdgeInsets.all(15),
                      // decoration: BoxDecoration(

                      //     border: Border(
                      //         top: BorderSide(
                      //             color: Color(0xFFc1dedc), width: 8))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Your Balance',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            '\$1000.00',
                            style: TextStyle(
                              fontSize: 35.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Divider(),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) => ExpensesScreen()),
                              );
                            },
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                'Add Transaction',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Color(0xFFc1dedc),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => GoalsScreen()),
                      );
                    },
                    child: Card(
                      color: Color(0xFFe6def0),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: ClipPath(
                        clipper: ShapeBorderClipper(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: Container(
                            height: 150,
                            width: 150,
                            padding: EdgeInsets.all(15),
                            // decoration: BoxDecoration(
                            //     border: Border(
                            //         top: BorderSide(
                            //             color: Color(0xFFc1dedc), width: 8))),
                            child: Text('Goals')),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => ExpensesScreen()),
                      );
                    },
                    child: Card(
                      color: Color(0xFFc1dedc),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: ClipPath(
                        clipper: ShapeBorderClipper(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: Container(
                            height: 150,
                            width: 150,
                            padding: EdgeInsets.all(15),
                            // decoration: BoxDecoration(
                            //     border: Border(
                            //         top: BorderSide(
                            //             color: Color(0xffd5c8c5), width: 8))),
                            child: Text('Spent today')),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => NewsHomeScreen()),
                  );
                },
                child: Card(
                    color: Color(0xFFf0edea),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: ClipPath(
                        clipper: ShapeBorderClipper(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: Container(
                            height: 100,
                            width: 400,
                            padding: EdgeInsets.all(15),
                            // decoration: BoxDecoration(
                            //     border: Border(
                            //         top: BorderSide(
                            //             color: Color(0xffd5c8c5), width: 8))),
                            child: Text('News')))),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => FinanciaSchool()),
                  );
                },
                child: Card(
                  color: Color(0xFFc1dedc),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ClipPath(
                    clipper: ShapeBorderClipper(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Container(
                        height: 100,
                        width: 400,
                        padding: EdgeInsets.all(15),
                        // decoration: BoxDecoration(
                        //     border: Border(
                        //         top: BorderSide(
                        //             color: Color(0xffd5c8c5), width: 8))),
                        child: Text('School')),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
