import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:intl/intl.dart';
import 'package:licenta/models/transaction_category.dart';
import 'package:licenta/models/user_transaction.dart';

class NewTransaction extends StatefulWidget {
  UserTransaction? transaction;
  final Function addTx;
  Function(UserTransaction) editTx;

  NewTransaction(this.addTx, this.transaction, this.editTx, {super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TransactionCategory _selectedCategory = TransactionCategory.others;

  @override
  void initState() {
    UserTransaction? transaction = widget.transaction;
    if (transaction == null) {
      return;
    }

    _selectedDate = transaction.date;
    _titleController.text = transaction.title;
    _amountController.text = "${transaction.amount}";
    _selectedCategory = transaction.category;
    super.initState();
  }

  void submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final category = _selectedCategory;
    final date = _selectedDate;
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return; // return opreste executia functiei!!!
    }

    UserTransaction? transaction = widget.transaction;

    if (transaction != null) {
      widget.editTx(UserTransaction(
          id: transaction.id,
          title: enteredTitle,
          amount: enteredAmount,
          date: date,
          category: category)
      );
    } else {
      widget.addTx(
        // codul acesta se executa in functie de if
        date,
        category,
        enteredTitle,
        enteredAmount,
      );
    }
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void _presentCategoryPicker() {
    List<TransactionCategory> categories = TransactionCategory.values;
    List<String> categoryList = categories
        .map((category) => category.stringValue())
        .toList();

    Picker(
      adapter: PickerDataAdapter<String>(pickerData: categoryList),
      selecteds: [_selectedCategory.index],
      hideHeader: true,
      title: const Text('Select Category'),
      onConfirm: (Picker picker, List<int> value) {
        setState(() {
          _selectedCategory = TransactionCategory.values[picker.selecteds.first];
        });
      },
    ).showDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                controller: _amountController,
                onSubmitted: (_) =>
                    submitData(), // (_) --- dau un argument, dar nu imi pasa de el
              ),
              SizedBox(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date Chosen!'
                            : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                      ),
                    ),
                    TextButton(
                      onPressed: _presentDatePicker,
                      style: TextButton.styleFrom(
                          primary: Theme.of(context).primaryColor),
                      child: const Text(
                        'Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Category: ${_selectedCategory.stringValue()}',
                      ),
                    ),
                    TextButton(
                      onPressed: _presentCategoryPicker,
                      style: TextButton.styleFrom(
                          primary: Theme.of(context).primaryColor),
                      child: const Text(
                        'Choose Category',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: submitData,
                style: TextButton.styleFrom(
                  primary: Colors.white,
                ),
                child: Text('${widget.transaction == null ? 'Add' : 'Edit'} Transaction'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
