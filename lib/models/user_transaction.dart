import 'package:licenta/models/transaction_category.dart';

class UserTransaction {
  String id;
  final String title;
  final double amount;
  final DateTime date;
  final TransactionCategory category;

  UserTransaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });

  factory UserTransaction.fromJson(Map<dynamic, dynamic> json) {
    return UserTransaction(
      id: json['id'],
      title: json['title'],
      amount: json['amount'].toDouble(),
      date: DateTime.parse(json['date']),
      category: TransactionCategory.values[json['category']],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'category': category.index,
    };
  }
}
