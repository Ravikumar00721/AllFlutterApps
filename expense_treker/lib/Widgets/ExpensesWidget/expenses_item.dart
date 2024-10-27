import 'package:expense_treker/model/exmodel.dart';
import 'package:flutter/material.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard(this.expenses, {super.key});

  final Expense expenses;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(expenses.title,
                style: Theme.of(context).textTheme.titleLarge,),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Text('\$${expenses.amount.toStringAsFixed(2)}'),
                    const Spacer(),
                    Row(
                      children: [
                           Icon(categoryIcons[expenses.category]),
                           const SizedBox(width: 8,),
                           Text(expenses.formatDate)
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
