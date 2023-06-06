import 'package:flutter/foundation.dart';
import 'package:licenta/models/transaction_category.dart';
import 'package:licenta/models/user_transaction.dart';
import 'package:licenta/services/transaction_service.dart';

class Transactions extends ChangeNotifier {
  List<UserTransaction> transactions = <UserTransaction>[];
  final service = TransactionService();

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> fetchTransactions() async {
    _isLoading = true;
    notifyListeners();

    transactions = await service.fetchTransactions();

    _isLoading = false;
    notifyListeners();
  }

  UserTransaction? getLatestTransaction() {
    if (transactions.isEmpty) {
      return null;
    }

    UserTransaction latestTransaction = transactions.reduce((current, next) {
      return current.date.isAfter(next.date) ? current : next;
    });

    return latestTransaction;
  }

  String computeLatestTransactionText() {
    UserTransaction? transaction = getLatestTransaction();

    if (transaction != null) {
      return '${transaction.amount} RON ${transaction.title}';
    }
    return 'No transactions yet';
  }

  List<UserTransaction> get todayTransactions {
    final today = DateTime.now();
    return transactions.where((tx) {
      return tx.date.year == today.year &&
          tx.date.month == today.month &&
          tx.date.day == today.day;
    }).toList();
  }

  Future<void> addTransaction(UserTransaction transaction) async {
    _isLoading = true;
    notifyListeners();

    await service.addTransaction(transaction);

    _isLoading = false;
    transactions.add(transaction);
    transactions.sort((a, b) => b.date.compareTo(a.date));

    notifyListeners();
  }

  Future<void> editTransaction(UserTransaction transaction) async {
    _isLoading = true;
    notifyListeners();

    await service.editTransaction(transaction);

    _isLoading = false;
    transactions.removeWhere((element) => element.id == transaction.id);
    transactions.add(transaction);
    transactions.sort((a, b) => b.date.compareTo(a.date));

    notifyListeners();
  }

  void deleteTransaction(String id) async {
    _isLoading = true;
    notifyListeners();

    await service.removeTransaction(id);

    _isLoading = false;
    transactions.removeWhere((tx) => tx.id == id);
    notifyListeners();
  }

  Map<String, double> computeStatistics() {
    Map<String, double> statisticsMap = {};

    for (var category in TransactionCategory.values) {
        statisticsMap[category.stringValue()] = transactions
            .where((transaction) => transaction.category == category)
            .fold(0.0, (sum, transaction) => sum + transaction.amount);
    }

    return statisticsMap;
  }
}