import 'package:flutter/material.dart';
import 'package:licenta/Screens/expenses_screen.dart';
import 'package:licenta/Screens/financial_school_screen.dart';
import 'package:licenta/Screens/goals_screen.dart';
import 'package:licenta/Screens/news_home_screen.dart';
import 'package:licenta/models/user_transaction.dart';
import 'package:licenta/services/transaction_service.dart';
import 'package:licenta/services/transactions_provider.dart';
import 'package:licenta/widgets/bottom_navigation_bar.dart';
import 'package:provider/provider.dart';

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
      appBar: AppBar(
        title: const Text(
          'Overview',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffE6DEF0),
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
                              builder: (_) => ExpensesScreen(
                                  title: 'Personal Expenses',
                                  transactions:
                                      transactionsProvider.transactions)),
                        );
                      },
                      child: Card(
                        color: const Color(0xFFf0edea),
                        elevation: 10,
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
                                      fontSize: 17,
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
                              color: const Color(0xFFe6def0),
                              elevation: 10,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: ClipPath(
                                clipper: ShapeBorderClipper(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                child: Container(
                                    height: 100,
                                    padding: const EdgeInsets.all(15),
                                    child: const Center(
                                        child: Text(
                                      'Goals',
                                      style: TextStyle(fontSize: 20),
                                    ))),
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
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) => ExpensesScreen(
                                        title: 'Spent today',
                                        transactions: transactionsProvider
                                            .todayTransactions)),
                              );
                            },
                            child: Card(
                              color: const Color(0xFFc1dedc),
                              elevation: 10,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: ClipPath(
                                clipper: ShapeBorderClipper(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                child: Container(
                                    height: 100,
                                    padding: const EdgeInsets.all(15),
                                    child: const Center(
                                        child: Text(
                                      'Spent today',
                                      style: TextStyle(fontSize: 20),
                                    ))),
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
                          color: const Color(0xFFf0edea),
                          elevation: 10,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: ClipPath(
                              clipper: ShapeBorderClipper(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: Container(
                                  height: 100,
                                  width: 400,
                                  padding: const EdgeInsets.all(15),
                                  child: const Center(
                                      child: Text(
                                    'See the latest News',
                                    style: TextStyle(fontSize: 20),
                                  ))))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => const FinanciaSchool()),
                        );
                      },
                      child: Card(
                        color: const Color(0xFFc1dedc),
                        elevation: 10,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: ClipPath(
                          clipper: ShapeBorderClipper(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: Container(
                              height: 100,
                              width: 400,
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Financial School',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Learn how to make your money work for you',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              )),
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
