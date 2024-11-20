import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

class DateSelector extends StatefulWidget {
  @override
  _DateSelectorState createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  DateTime selectedDate = DateTime.now();
  final DateFormat monthFormat = DateFormat('MMMM', 'id_ID');

  void changeDate(int days) {
    setState(() {
      selectedDate = selectedDate.add(Duration(days: days));
    });
  }

  List<int> generateYearList(int range) {
    int currentYear = DateTime.now().year;
    return List<int>.generate(range, (index) => currentYear - range ~/ 2 + index);
  }

  @override
  Widget build(BuildContext context) {
    List<String> months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_left),
          onPressed: () {
            changeDate(-1);
          },
        ),
        _buildDateDropdown(
          selectedDate.day,
          List<int>.generate(31, (index) => index + 1),
          (int? newDay) {
            if (newDay != null) {
              setState(() {
              selectedDate = DateTime(
                selectedDate.year,
                selectedDate.month,
                newDay,
              );
            });
            }
          },
        ),
        _buildDateDropdown(
          selectedDate.month,
          List<int>.generate(12, (index) => index + 1),
          (int? newMonth) {
            if (newMonth != null) {
              setState(() {
              selectedDate = DateTime(
                selectedDate.year,
                newMonth,
                selectedDate.day,
              );
            });
            }
          },
          displayText: (int month) => months[month - 1],
        ),
        _buildDateDropdown(
          selectedDate.year,
          generateYearList(50),
          (int? newYear) {
            if (newYear != null) {
              setState(() {
              selectedDate = DateTime(
                newYear,
                selectedDate.month,
                selectedDate.day,
              );
            });
            }
          },
        ),
        IconButton(
          icon: Icon(Icons.arrow_right),
          onPressed: () {
            changeDate(1);
          },
        ),
      ],
    );
  }

  Widget _buildDateDropdown<T>(
      T value, List<T> items, ValueChanged<T?>? onChanged,
      {String Function(T)? displayText}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2),
      padding: EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: DropdownButton<T>(
        value: value,
        onChanged: onChanged,
        items: items.map((item) {
          return DropdownMenuItem<T>(
            value: item,
            child:  Row(
            mainAxisSize: MainAxisSize.min, // Agar widget tidak terlalu lebar
            children: [
              Text(
                displayText != null ? displayText(item) : item.toString(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              // SizedBox(width: 4), // Atur jarak antara teks dan ikon
              
            ],
          ),
          );
        }).toList(),
        icon: Visibility (
          visible:true, 
          child:Transform.rotate(
            angle: -45 * math.pi / 180, // Contoh rotasi 45 derajat
            child: Icon(
              Icons.arrow_drop_down,
              color: Color(0xFF4F46E5),
              size: 24,
            ),
          ),
        ),
        underline: SizedBox(),
      ),
    );
  }
}