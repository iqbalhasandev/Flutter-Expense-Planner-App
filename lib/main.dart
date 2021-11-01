// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import './widgets/new_transaction.dart';
import './widgets/transction_list.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Expense Planner App",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  void startAddNewTransction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (btx) {
          return GestureDetector(
            onTap: () {},
            child: NewTransction(_addNewTransction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Expense Planner"), actions: [
        IconButton(
            onPressed: () => startAddNewTransction(context),
            icon: Icon(Icons.add))
      ]),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                color: Colors.blue,
                child: Text("top text"),
                elevation: 5,
              ),
            ),
            TransctionList(_userTransactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => startAddNewTransction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
