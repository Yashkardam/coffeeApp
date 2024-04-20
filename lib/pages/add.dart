import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddCoffeePage extends StatefulWidget {
  const AddCoffeePage({Key? key}) : super(key: key);

  @override
  _AddCoffeePageState createState() => _AddCoffeePageState();
}

class _AddCoffeePageState extends State<AddCoffeePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _imgPathController = TextEditingController(); // Changed to match the backend model

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Coffee'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the coffee name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the coffee price';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imgPathController,
                decoration: InputDecoration(labelText: 'Image Path'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the image path';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _addCoffee();
                  }
                },
                child: Text('Add Coffee'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addCoffee() async {
    // Get the values from the text controllers
    String name = _nameController.text;
    String price = _priceController.text;
    String imgPath = _imgPathController.text; // Changed to match the backend model

    // Send the coffee data to the backend
    final response = await http.post(
      Uri.parse('http://192.168.0.106:3000/add'), // Replace with your backend endpoint
      headers: {'Content-Type': 'application/json'}, // Ensure correct Content-Type
      body: jsonEncode({
        'name': name,
        'price': price,
        'imgPath': imgPath,
      }),
    );

    if (response.statusCode == 200) {
      // Show a success message or navigate to another screen
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Coffee added successfully'),
        duration: Duration(seconds: 2),
      ));
    } else {
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to add coffee'),
        duration: Duration(seconds: 2),
      ));
    }
  }
}