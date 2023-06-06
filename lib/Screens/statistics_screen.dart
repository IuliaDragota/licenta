import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:licenta/Screens/main_screen.dart';
import 'package:licenta/Screens/profile_screen.dart';
import 'package:licenta/services/transactions_provider.dart';
import 'package:licenta/widgets/bottom_navigation_bar.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Statistics',
          style: TextStyle(color: Colors.black),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffE6DEF0),
      ),
      bottomNavigationBar: const CustomNavigationBar(selectedIndex: 1),
      body: Consumer<Transactions>(
        builder: (context, transactionsProvider, _) {
          if (transactionsProvider.isLoading) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFFB494DB)));
          }
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                PieChart(
                  dataMap: transactionsProvider.computeStatistics(),
                  chartType: ChartType.ring,
                  colorList: const [
                    Color(0xFFc1dedc),
                    Color(0xFFF1DECA),
                    Color(0xFFe6def0),
                    Color(0xFFB9A9BD),
                  ],
                )
              ],
            ),
          );
        }
    )
    );
  }
}