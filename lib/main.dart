// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import './widgets/new_transaction.dart';
import './widgets/transction_list.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Expense Planner App",
      home: MyHomePage(),
      theme: ThemeData(
        primaryColor: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
            headline1: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            button: TextStyle(color: Colors.white)),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline1: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 35,
                ),
              ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];

  List<Transaction> get _recentTransctions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(Duration(days: 7)),
      );
    }).toList();
  }

  void _addNewTransction(String txTitle, double txAmount, DateTime chosenDate) {
    final newTX = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
    );

    setState(() {
      _userTransactions.add(newTX);
    });
  }

  void _startAddNewTransction(BuildContext ctx) {
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

  void _deleteTransction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(
        "Expense Planner",
        // style: Theme.of(context).appBarTheme.textTheme.headline1,
      ),
      actions: [
        IconButton(
          onPressed: () => _startAddNewTransction(context),
          icon: Icon(Icons.add),
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.3,
              child: Chart(_recentTransctions),
            ),
            Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: TransctionList(_userTransactions, _deleteTransction),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
