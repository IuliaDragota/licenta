import 'package:flutter/material.dart';
import 'package:licenta/models/user_transaction.dart';
import 'package:licenta/models/transaction_category.dart';
import 'package:licenta/providers/transactions_provider.dart';
import 'package:licenta/widgets/chart.dart';
import 'package:licenta/widgets/new_transaction.dart';
import 'package:licenta/widgets/transaction_list.dart';
import 'package:provider/provider.dart';

class ExpensesScreen extends StatefulWidget {
  final String title;
  final bool showToday;
  const ExpensesScreen({Key? key, required this.title, required this.showToday})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ExpensesScreenState();
  }
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  bool _showChart = false;

  List<UserTransaction> recentTransactions(List<UserTransaction> transactions) {
    return transactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 31),
        ),
      );
    }).toList();
  }

  Future<void> _addNewTransaction(DateTime date, TransactionCategory category,
      String txTitle, double txAmount) async {
    final newTx = UserTransaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: date,
      category: category,
    );

    Provider.of<Transactions>(context, listen: false).addTransaction(newTx);
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(
                _addNewTransaction,
                null,
                (_) =>
                    {}), //important deoarece are grija sa nu se inchida cand apesi pe textbox
          );
        });
  }

  void _deleteTransaction(String id) {
    showDeleteConfirmationDialog(context, id);
  }

  void _didSelectTransaction(UserTransaction transaction) {
    showEditTransaction(transaction);
  }

  showEditTransaction(UserTransaction transaction) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(
                () => {},
                transaction,
                (editedTransaction) => {
                      Provider.of<Transactions>(context, listen: false)
                          .editTransaction(editedTransaction)
                    }),
          );
        });
  }

  showDeleteConfirmationDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content:
              const Text('Are you sure you want to delete this transaction?'),
          actions: [
            TextButton(
              child: const Text(
                'No',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Provider.of<Transactions>(context, listen: false)
                    .deleteTransaction(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Transactions>(
      builder: (context, transactionsProvider, _) {
        final mediaQuery = MediaQuery.of(context);
        final isLandscape = mediaQuery.orientation == Orientation.landscape;
        final appBar = AppBar(
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: Colors.white,
            title: Text(
              widget.title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black),
            ),
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(6.0),
                child: transactionsProvider.isLoading
                    ? const LinearProgressIndicator(
                        color: Colors.deepPurpleAccent,
                        backgroundColor: Color(0xFFB494DB))
                    : const SizedBox()));
        final txListWidget = SizedBox(
            height: (mediaQuery.size.height -
                    appBar.preferredSize.height -
                    mediaQuery.padding.top) *
                0.7,
            child: transactionsProvider.isLoading
                ? const SizedBox()
                : TransactionList(
                    widget.showToday
                        ? transactionsProvider.todayTransactions
                        : transactionsProvider.transactions,
                    _deleteTransaction,
                    _didSelectTransaction));

        return Scaffold(
          appBar: appBar,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                if (isLandscape)
                  Row(
                    children: <Widget>[
                      const Text('Show Chart'),
                      Switch(
                        value: _showChart,
                        onChanged: (val) {
                          setState(
                            () {
                              _showChart = val;
                            },
                          );
                        },
                      ),
                    ],
                  ),
                if (!isLandscape)
                  SizedBox(
                    //daca nu suntem in lanscape vreau sa afiseze ce e mai jos
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.5,
                    child: SimpleBarChart(
                      widget.showToday
                          ? recentTransactions(
                              transactionsProvider.todayTransactions)
                          : recentTransactions(
                              transactionsProvider.transactions),
                      animate: false,
                    ),
                  ),
                if (!isLandscape) txListWidget,
                if (isLandscape)
                  _showChart
                      ? SizedBox(
                          height: (mediaQuery.size.height -
                                  appBar.preferredSize.height -
                                  mediaQuery.padding.top) *
                              0.55,
                          child: SimpleBarChart(
                            recentTransactions(
                                transactionsProvider.transactions),
                            animate: false,
                          ),
                        )
                      : txListWidget
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0xFF383838),
            child: const Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          ),
        );
      },
    );
  }
}
