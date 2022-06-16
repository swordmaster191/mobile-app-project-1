import 'package:project_1/view_expense_data.dart';
import 'package:project_1/view_income_data.dart';
import 'package:project_1/home.dart';
import 'package:flutter/material.dart';
//https://www.youtube.com/watch?v=WG5tJIAq5b0&list=PL4cUxeGkcC9jLYyp2Aoh6hcWuxFDX6PBJ&index=23
void main() {
  runApp(
      MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home': (context) => Home(),
        '/incomeData': (context) => ViewIncomeData(),
        '/expenseData': (context) => ViewExpenseData(),
      }
  ));
}


