import 'package:flutter/material.dart';
import 'package:licenta/models/user_transaction.dart';
import 'package:intl/intl.dart';
import 'package:licenta/models/transaction_category.dart';

class TransactionList extends StatelessWidget {
  final List<UserTransaction> transactions;
  final Function deletetx;
  final Function didSelect;

  const TransactionList(this.transactions, this.deletetx, this.didSelect,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 20, //pentru spatiu intre text si imagine
                ),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color(0xFF383838),
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                          child: Text(
                        '${transactions[index].amount}',
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(transactions[index].title,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold)),
                      Text(
                        transactions[index].category.stringValue(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 460
                      ? TextButton.icon(
                          icon: const Icon(Icons.delete),
                          label: const Text('Delete'),
                          style: TextButton.styleFrom(
                              primary: Theme.of(context).errorColor),
                          onPressed: () => deletetx(transactions[index].id),
                        )
                      : IconButton(
                          icon: const Icon(Icons.delete),
                          color: Color(0xFF383838),
                          onPressed: () => deletetx(transactions[index].id),
                        ),
                  onTap: () => {didSelect(transactions[index])},
                ),
              );
            },
            itemCount:
                transactions.length, //cate obiecte ar trebui sa fie construite
          );
  }
}
