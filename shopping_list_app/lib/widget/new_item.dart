import 'package:flutter/material.dart';
import 'package:shopping_list_app/data/categories.dart';
import 'package:shopping_list_app/model/categories_model.dart';
import 'package:shopping_list_app/model/grocery_model.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() {
    return _NewItemState();
  }
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>();
  late var _enteredName = '';
  late var _enteredQ = 1;
  late var _selectedCategories = categories[Categories.vegetables]!;

  void saveItem() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.of(context).pop(GroceryItem(
          id: DateTime.timestamp().toString(),
          name: _enteredName,
          quantity: _enteredQ,
          category: _selectedCategories));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Items"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Name Field with Updated Validator
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(labelText: "Name"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a valid name';
                  }
                  if (RegExp(r'[0-9]').hasMatch(value)) {
                    return 'Name cannot contain numbers';
                  }
                  if (value.trim().length > 50) {
                    return 'Name cannot be more than 50 characters';
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredName = value!;
                },
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Quantity Field with Corrected Validator
                  SizedBox(
                    width: 80,
                    child: TextFormField(
                      initialValue: _enteredQ.toString(),
                      decoration: const InputDecoration(labelText: 'Quantity'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Enter a quantity';
                        }
                        final number = int.tryParse(value);
                        if (number == null || number <= 0) {
                          return 'Must be a positive number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _enteredQ = int.parse(value!);
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Category Dropdown
                  Expanded(
                    child: DropdownButtonFormField(
                      value: _selectedCategories,
                      items: categories.entries.map((category) {
                        return DropdownMenuItem(
                          value: category.value,
                          child: Row(
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                color: category.value.color,
                              ),
                              const SizedBox(width: 5),
                              Text(category.value.title),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategories = value!;
                        });
                      },
                      decoration: const InputDecoration(labelText: 'Category'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        _formKey.currentState!.reset();
                      },
                      child: const Text("Reset")),
                  ElevatedButton(
                      onPressed: saveItem, child: const Text("Add Item"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
