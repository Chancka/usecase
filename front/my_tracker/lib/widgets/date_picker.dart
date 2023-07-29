import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  @override
  _DatePickerState createState() => _DatePickerState();
}

// DatePicker widget, a button that shows a date picker when pressed and displays the selected date
class _DatePickerState extends State<DatePicker> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _showDatePicker(BuildContext context) async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (newDate != null && newDate != _selectedDate) {
      setState(() {
        _selectedDate = newDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ), 
      onPressed: () => _showDatePicker(context),
      child: Text('Selected Date: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'),
    );
  }
}