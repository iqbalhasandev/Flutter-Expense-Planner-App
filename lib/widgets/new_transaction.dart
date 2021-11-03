import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransction extends StatefulWidget {
  final Function addTx;

  NewTransction(this.addTx);

  @override
  State<NewTransction> createState() => _NewTransctionState();
}

class _NewTransctionState extends State<NewTransction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();
  DateTime? _selectDate;

  void _submitData() {
    if (_amountController.text.isEmpty) return;
    final _enteredTitle = _titleController.text;
    final _enteredAmount = double.parse(_amountController.text);

    if (_enteredTitle.isEmpty || _enteredAmount <= 0 || _selectDate == null)
      return;

    widget.addTx(_enteredTitle, _enteredAmount, _selectDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;

      setState(() {
        _selectDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
              child: Row(
                children: [
                  Expanded(
                    child: Text(_selectDate == null
                        ? 'No date Chosen!'
                        : 'picked date: ' +
                            DateFormat.yMMMEd()
                                .format((_selectDate as DateTime))),
                  ),
                  FlatButton(
                    onPressed: _presentDatePicker,
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            RaisedButton(
              onPressed: _submitData,
              child: Text('Add Transaction'),
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
