import 'package:flutter/material.dart';
import 'package:licenta/Screens/expenses_screen.dart';
import 'package:licenta/Screens/goals_screen.dart';
import 'package:licenta/Screens/news_home_screen.dart';
import 'package:licenta/providers/transactions_provider.dart';
import 'package:licenta/screens/financial_school_screen.dart';
import 'package:licenta/widgets/bottom_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<Transactions>(context, listen: false).fetchTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD8F3F3),
      appBar: AppBar(
        elevation: 0,
        title: Center(
          child: const Text(
            'Overview',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffD8F3F3),
      ),
      bottomNavigationBar: const CustomNavigationBar(selectedIndex: 0),
      body: Padding(
          padding: const EdgeInsets.all(15),
          child: Consumer<Transactions>(
            builder: (context, transactionsProvider, _) {
              if (transactionsProvider.isLoading) {
                return const Center(
                    child: CircularProgressIndicator(color: Color(0xFFB494DB)));
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => const ExpensesScreen(
                                  title: 'Personal Expenses',
                                  showToday: false)),
                        );
                      },
                      child: Card(
                        color: Color(0xffD8F3F3),
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: ClipPath(
                          clipper: ShapeBorderClipper(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: Container(
                            height: 200,
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Latest Transaction',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                Text(
                                  transactionsProvider
                                      .computeLatestTransactionText(),
                                  style: const TextStyle(
                                    fontSize: 35.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Divider(),
                                const Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    'Add Transaction',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) => GoalsScreen()),
                              );
                            },
                            child: Card(
                              color: Colors.white,
                              elevation: 7,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      padding: const EdgeInsets.all(15),
                                      child: CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Color(0xffD8F3F3),
                                        child: Icon(
                                          FeatherIcons.checkSquare,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  ClipPath(
                                    clipper: ShapeBorderClipper(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Container(
                                      height: 100,
                                      padding: const EdgeInsets.all(15),
                                      child: const Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              'Goals',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              final today = DateTime.now();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => const ExpensesScreen(
                                        title: 'Spent today',
                                        showToday: true,
                                      )));
                            },
                            child: Card(
                              color: Colors.white,
                              elevation: 7,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Color(0xffD8F3F3),
                                        child: Icon(
                                          FeatherIcons.dollarSign,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  ClipPath(
                                    clipper: ShapeBorderClipper(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Container(
                                      height: 100,
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Center(
                                            child: Text(
                                              'Spent today ',
                                              style: const TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Text(
                                            ' ${transactionsProvider.todayTotalSpent} RON',
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => const NewsHomeScreen()),
                        );
                      },
                      child: Card(
                        color: Colors.white,
                        elevation: 7,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: CircleAvatar(
                                  backgroundColor: Color(0xffD8F3F3),
                                  radius: 18,
                                  child: Icon(
                                    FeatherIcons.bell,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            ClipPath(
                              clipper: ShapeBorderClipper(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Container(
                                height: 100,
                                width: 400,
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Center(
                                      child: Text(
                                        'See the latest News',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => const FinancialSchool()),
                        );
                      },
                      child: Card(
                        color: Colors.white,
                        elevation: 7,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: CircleAvatar(
                                  backgroundColor: Color(0xffD8F3F3),
                                  radius:
                                      18, // Ajustează această valoare pentru a face cercul mai mic
                                  child: Icon(
                                    FeatherIcons.bookOpen,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            ClipPath(
                              clipper: ShapeBorderClipper(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Container(
                                height: 100,
                                width: 400,
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      'Financial School',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Learn how to make your money work for you',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                          color:
                                              Color.fromARGB(221, 41, 41, 41)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          )),
    );
  }
}
