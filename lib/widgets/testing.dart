import 'dart:math';

import 'package:finanseeup/widgets/expense.dart';
import 'package:flutter/material.dart';

class Testing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ExpenseBarGraph(
          expenses: List.generate(30, (index) {
            // Generating dummy expenses for the last 15 days
            Random random = Random();
            return Expense(
              date: DateTime.now().subtract(Duration(days: index)),
              amount: random.nextDouble() *
                  1200.0, // Generate random amount between 0 and 1000
            );
          }),
        ),
        ExpenseBarGraph(
          expenses: List.generate(30, (index) {
            // Generating dummy expenses for the last 15 days
            Random random = Random();
            return Expense(
              date: DateTime.now().subtract(Duration(days: index)),
              amount: random.nextDouble() *
                  1200.0, // Generate random amount between 0 and 1000
            );
          }),
        ),
        ExpenseBarGraph(
          expenses: List.generate(30, (index) {
            // Generating dummy expenses for the last 15 days
            Random random = Random();
            return Expense(
              date: DateTime.now().subtract(Duration(days: index)),
              amount: random.nextDouble() *
                  1200.0, // Generate random amount between 0 and 1000
            );
          }),
        ),
        ExpenseBarGraph(
          expenses: List.generate(30, (index) {
            // Generating dummy expenses for the last 15 days
            Random random = Random();
            return Expense(
              date: DateTime.now().subtract(Duration(days: index)),
              amount: random.nextDouble() *
                  1200.0, // Generate random amount between 0 and 1000
            );
          }),
        ),
        ExpenseBarGraph(
          expenses: List.generate(30, (index) {
            // Generating dummy expenses for the last 15 days
            Random random = Random();
            return Expense(
              date: DateTime.now().subtract(Duration(days: index)),
              amount: random.nextDouble() *
                  1200.0, // Generate random amount between 0 and 1000
            );
          }),
        ),
      ],
    );
  }
}
