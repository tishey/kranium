import 'package:flutter/material.dart';

import './widgets/new_transaction.dart';
import './model/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import '../widgets/button.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Karium',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        errorColor: Colors.red,
        fontFamily: 'MontserratAlternates',
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
    // Transaction(
    //   id: 'item1',
    //    title: 'cloth1',
    //    amount: 69.99,
    //    date: DateTime.now(),
    //  ),
    //  Transaction(
    //    id: 'item2',
    //    title: 'cloth2',
    //    amount: 69.99,
    //    date: DateTime.now(),
    //  ),
  ];

  List<Transaction> get _recentTransaction {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      )
      );
    }).toList();
  }

  void _addNewTransaction(String txtitle, double txamount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txtitle,
      amount: txamount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque);
      },
    );
  }

  void _deleteTransaction(String id) {
    setState((){
      _userTransaction.removeWhere((tx) => tx.id == id );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
          title: Text(
            'Kranium List',
            style: TextStyle(fontFamily: 'MontserratAlternates'),
          textAlign: TextAlign.center,
          
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _startAddNewTransaction(context),
            ),
            
          ]),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
            //  color: Colors.amber,
              child: Chart( _recentTransaction),
            //  elevation: 6,
            ),
            TransactionList(_userTransaction, _deleteTransaction),
          ],
        ),
      ),
        
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
        
      ),
    ,CustomButton
     (onPressed: (){})
     
    );
  }
}
