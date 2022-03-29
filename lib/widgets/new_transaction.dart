import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'button.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
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

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                controller: _titleController,
                // onChanged: (val) {
                //   titleInput = val;
                //   },
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(),
                ),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
                // onChanged: (val) {
                //   amountInput = val;
                //  },
              ),
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      _selectedDate == null
                          ? 'No Date Chosen'
                          : 'Selected: ${DateFormat.yMMMd().format(_selectedDate)}',
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: RaisedButton(
                      child: Text('SUBMIT'),
                      color: Colors.amber,
                      textColor: Colors.black,
                      onPressed: () => _submitData(),
                    ),
                  ),
                  CustomButton(onPressed: () {}),
                  FlatButton(
                      child: Text(
                        'Select a Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        //   textAlign: TextAlign.center,
                      ),
                      textColor: Theme.of(context).primaryColor,
                      onPressed: _presentDatePicker
                      )
                ]),
          ],
        ),
      ),
    );
  }
}
