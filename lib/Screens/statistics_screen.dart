import 'package:flutter/material.dart';
import 'package:licenta/providers/transactions_provider.dart';
import 'package:licenta/widgets/bottom_navigation_bar.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5EFF9),
      appBar: AppBar(
        elevation: 0,
        title: Center(
          child: const Text(
            'Statistics',
            style: TextStyle(color: Colors.black),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFE5EFF9),
      ),
      bottomNavigationBar: const CustomNavigationBar(selectedIndex: 1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<Transactions>(
            builder: (context, transactionsProvider, _) {
              if (transactionsProvider.isLoading) {
                return const Center(
                    child: CircularProgressIndicator(color: Color(0xFFB494DB)));
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
            },
          ),
        ],
      ),
    );
  }
}
