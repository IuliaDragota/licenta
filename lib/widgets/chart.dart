import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:licenta/models/user_transaction.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class SimpleBarChart extends StatelessWidget {
  final List<UserTransaction> recentTransactions;
  final bool animate;

  SimpleBarChart(this.recentTransactions, {required this.animate});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> groupedTransactionValues =
        List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();

    double totalSpending = groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });

    List<charts.Series<Map<String, dynamic>, String>> seriesList = [
      new charts.Series<Map<String, dynamic>, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.gray.shadeDefault,
        domainFn: (data, _) => data['day'] as String,
        measureFn: (data, _) => data['amount'] as double,
        data: groupedTransactionValues,
      )
    ];

    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Total spending: ${totalSpending.toStringAsFixed(2)} RON',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: new charts.BarChart(
                seriesList,
                animate: animate,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
