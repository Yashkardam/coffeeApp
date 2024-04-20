import 'package:flutter/material.dart';
import 'coffee.dart'; // Import the Coffee class
import 'package:http/http.dart' as http;
import 'dart:convert';

class CoffeeShop extends ChangeNotifier {
  final List<Coffee> _shop = [];
  List<Coffee> _userCart = [];

  List<Coffee> get coffeeShop => _shop;

  List<Coffee> get userCart => _userCart;

  // Constructor
  CoffeeShop() {
    fetchCoffeeList(); // Call fetchCoffeeList method when CoffeeShop instance is created
  }

  Future<void> fetchCoffeeList() async {
    final response = await http.get(Uri.parse('http://192.168.0.106:3000/getCoffee'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      final List<dynamic> data = jsonResponse['success']; // Access the 'success' property
      _shop.clear();
      _shop.addAll(data.map((json) => Coffee.fromJson(json)).toList());
      notifyListeners();
    } else {
      throw Exception('Failed to fetch coffee list');
    }
  }


  void addItemToCart(Coffee coffee) {
    _userCart.add(coffee);
    notifyListeners();
  }

  void removeItemFromCart(Coffee coffee) {
    _userCart.remove(coffee);
    notifyListeners();
  }
  void clearCart() {
    _userCart.clear();
    notifyListeners();
  }

}
