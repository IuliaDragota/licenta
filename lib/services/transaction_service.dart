import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:licenta/models/user_transaction.dart';

class TransactionService {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();
  String? userId = FirebaseAuth.instance.currentUser?.uid;

  Future<List<UserTransaction>> fetchTransactions() async {
    if (userId == null) {
      return [];
    }

    final reference = await _databaseRef.child('transactions/$userId').once();
    final transactionMap = reference.snapshot.value as Map<dynamic, dynamic>?;
    if (transactionMap == null) {
      return [];
    }

    final transactions = transactionMap.entries.map((entry) {
      return UserTransaction.fromJson(entry.value);
    }).toList();

    transactions.sort((a, b) => b.date.compareTo(a.date));
    return transactions;
  }

  Future<void> addTransaction(UserTransaction transaction) async {
    if (userId == null) {
      return;
    }
    final newTransactionRef = _databaseRef.child('transactions/$userId').push();
    final newTransactionId = newTransactionRef.key;
    if (newTransactionId == null) {
      // Handle error when generating the new transaction ID
      return;
    }

    transaction.id = newTransactionId;
    await newTransactionRef.set(transaction.toJson());
  }

  Future<void> editTransaction(UserTransaction transaction) async {
    if (userId == null) {
      return;
    }
    final editTransactionRef = _databaseRef.child('transactions/$userId/${transaction.id}');
    await editTransactionRef.set(transaction.toJson());
  }

  Future<void> removeTransaction(String transactionId) async {
    if (userId == null) {
      return;
    }
    await _databaseRef.child('transactions/$userId/$transactionId').remove();
  }
}