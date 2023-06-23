import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:licenta/models/user_transaction.dart';

import 'package:charts_flutter/flutter.dart' as charts;

class SimpleBarChart extends StatelessWidget {
  final List<UserTransaction> recentTransactions;
  final bool animate;

  SimpleBarChart(this.recentTransactions, {required this.animate});

  double _calculateTotalSpendingThisWeek() {
    final currentDate = DateTime.now();
    double totalSum = 0.0;

    for (int i = 6; i >= 0; i--) {
      final weekDay = currentDate.subtract(Duration(days: i));
      final dayTransactions = recentTransactions.where((tx) =>
          tx.date.year == weekDay.year &&
          tx.date.month == weekDay.month &&
          tx.date.day == weekDay.day);

      final totalSumDay =
          dayTransactions.fold(0.0, (sum, tx) => sum + tx.amount);

      totalSum += totalSumDay;
    }

    return totalSum;
  }

  double _calculateTotalSpendingThisMonth() {
    final currentDate = DateTime.now();
    double totalSum = 0.0;

    for (final tx in recentTransactions) {
      if (tx.date.month == currentDate.month &&
          tx.date.year == currentDate.year) {
        totalSum += tx.amount;
      }
    }

    return totalSum;
  }

  @override
  Widget build(BuildContext context) {
    Map<int, double> groupedTransactionValues = {};

    DateTime currentDate = DateTime.now();
    double totalSpendingThisWeek = _calculateTotalSpendingThisWeek();
    double totalSpendingThisMonth = _calculateTotalSpendingThisMonth();

    for (int i = 6; i >= 0; i--) {
      final weekDay = currentDate.subtract(Duration(days: i));
      final dayTransactions = recentTransactions.where((tx) =>
          tx.date.year == weekDay.year &&
          tx.date.month == weekDay.month &&
          tx.date.day == weekDay.day);

      final totalSum = dayTransactions.fold(0.0, (sum, tx) => sum + tx.amount);

      groupedTransactionValues[i] = totalSum;
    }

    double totalSpending = recentTransactions
        .where((tx) =>
            tx.date.month == currentDate.month &&
            tx.date.year == currentDate.year)
        .fold(0.0, (sum, tx) => sum + tx.amount);

    List<charts.Series<dynamic, String>> seriesList = [
      charts.Series<dynamic, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.gray.shadeDefault,
        domainFn: (data, _) => DateFormat.E().format(
          currentDate.subtract(Duration(days: data.key)),
        ),
        measureFn: (data, _) => data.value,
        data: groupedTransactionValues.entries.toList(),
      ),
    ];

    return Container(
      child: Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Total spending this week: ${totalSpendingThisWeek.toStringAsFixed(2)} RON',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'Total spending this month: ${totalSpendingThisMonth.toStringAsFixed(2)} RON',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Expanded(
                child: charts.BarChart(
                  seriesList,
                  animate: animate,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
