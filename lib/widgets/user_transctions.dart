import 'package:flutter/material.dart';
import './new_transaction.dart';
import './transction_list.dart';
import '../models/transaction.dart';

class UserTransctions extends StatefulWidget {
  const UserTransctions({Key? key}) : super(key: key);

  @override
  _UserTransctionsState createState() => _UserTransctionsState();
}

class _UserTransctionsState extends State<UserTransctions> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
  ];

  void _addNewTransction(String txTitle, double txAmount) {
    final newTX = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
    );

    setState(() {
      _userTransactions.add(newTX);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransction(_addNewTransction),
        TransctionList(_userTransactions),
      ],
    );
  }
}
