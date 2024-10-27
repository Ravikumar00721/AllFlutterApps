import 'package:expense_treker/Widgets/ExpensesWidget/express_list.dart';
import 'package:expense_treker/Widgets/ExpensesWidget/new_expense.dart';
import 'package:expense_treker/Widgets/chart.dart';
import 'package:flutter/material.dart';
import 'package:expense_treker/model/exmodel.dart'; // Ensure this is the correct path

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: "Flutter Course",
      amount: 19.99,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: "Training Course",
      amount: 20.99,
      date: DateTime.now(),
      category: Category.work,
    ),
  ];

  void _expensesAddOverLay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpenses(
        onAddExpense: _addExpense, // Pass the add expense callback
      ),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense); // Add the new expense
    });
    // Close the modal after adding the expense
  }

  void _removeExpense(Expense expense) {
    final expenseindex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Expense Deleted"),
      duration: Duration(seconds: 3),
      action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseindex, expense);
            });
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget mainContent = const Center(
      child: Text('No Expenses Found.Start adding Some !'),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Trekker"),
        actions: [
          IconButton(
            onPressed: _expensesAddOverLay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width<600 ?Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(
            child: mainContent, // Pass the registered expenses
          ),
        ],
      )
      :Row(
        children: [
          Expanded(child: Chart(expenses: _registeredExpenses)),
          Expanded(
            child: mainContent, // Pass the registered expenses
          ),
        ],
      ),
    );
  }
}
