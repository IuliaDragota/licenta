enum TransactionCategory {
  food,
  entertainment,
  housing,
  others
}

extension TransactionCategoryExtension on TransactionCategory {
  String stringValue() {
    switch (this) {
      case TransactionCategory.food:
        return 'Food';
      case TransactionCategory.entertainment:
        return 'Entertainment';
      case TransactionCategory.housing:
        return 'Housing';
      case TransactionCategory.others:
        return 'Others';
      default:
        return '';
    }
  }
}