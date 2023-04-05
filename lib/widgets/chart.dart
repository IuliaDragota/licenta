import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:licenta/models/transaction.dart';
import 'package:licenta/widgets/chart_bar.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class SimpleBarChart extends StatelessWidget {
  final List<Transaction> recentTransactions;
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


// class SimpleBarChart extends StatelessWidget {
//   final List<charts.Series<OrdinalSales, String>> seriesList;
//   final bool animate;

//   SimpleBarChart(this.seriesList, {required this.animate});

//   /// Creates a [BarChart] with sample data and no transition.
//   factory SimpleBarChart.withSampleData() {
//     return new SimpleBarChart(
//       _createSampleData(),
//       // Disable animations for image tests.
//       animate: false,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new charts.BarChart(
//       seriesList,
//       animate: animate,
//     );
//   }

//   /// Create one series with sample hard coded data.
//   static List<charts.Series<OrdinalSales, String>> _createSampleData() {
//     final data = [
//       new OrdinalSales('2014', 5),
//       new OrdinalSales('2015', 25),
//       new OrdinalSales('2016', 100),
//       new OrdinalSales('2017', 75),
//     ];

//     return [
//       new charts.Series<OrdinalSales, String>(
//         id: 'Sales',
//         colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
//         domainFn: (OrdinalSales sales, _) => sales.year,
//         measureFn: (OrdinalSales sales, _) => sales.sales,
//         data: data,
//       )
//     ];
//   }
// }

// /// Sample ordinal data type.
// class OrdinalSales {
//   final String year;
//   final int sales;

//   OrdinalSales(this.year, this.sales);
// }

// class Chart extends StatelessWidget {
//   final List<Transaction> recentTransactions;

//   Chart(this.recentTransactions);

//   List<Map<String, dynamic>> get groupedTransactionValues {
//     return List.generate(7, (index) {
//       final weekDay = DateTime.now().subtract(
//         Duration(days: index),
//       );
//       var totalSum = 0.0;

//       for (var i = 0; i < recentTransactions.length; i++) {
//         if (recentTransactions[i].date.day == weekDay.day &&
//             recentTransactions[i].date.month == weekDay.month &&
//             recentTransactions[i].date.year == weekDay.year) {
//           totalSum += recentTransactions[i].amount;
//         }
//       }

//       print(DateFormat.E().format(weekDay));
//       print(totalSum);

//       return {
//         'day': DateFormat.E().format(weekDay).substring(0, 1),
//         'amount': totalSum,
//       };
//     }).reversed.toList();
//   }

//   double get totalSpending {
//     return groupedTransactionValues.fold(0.0, (sum, item) {
//       return sum + (item['amount'] as double);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     print(groupedTransactionValues);
//     return Card(
//       elevation: 6,
//       margin: EdgeInsets.all(20),
//       child: Container(
//         padding: EdgeInsets.all(10),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: groupedTransactionValues.map((data) {
//             return Flexible(
//               flex: 2,
//               fit: FlexFit.tight,
//               child: ChartBar(
//                   data['day'].toString(),
//                   data['amount'] as double,
//                   totalSpending == 0.0
//                       ? 0.0
//                       : (data['amount'] as double) / totalSpending),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }
