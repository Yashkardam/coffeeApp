import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:coffeapp/models/coffee.dart';
import 'package:coffeapp/models/coffee_shop.dart';
import 'package:coffeapp/components/coffee_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Remove items from cart
  void removeFromCart(Coffee coffee) {
    Provider.of<CoffeeShop>(context, listen: false).removeItemFromCart(coffee);
  }

  Future<void> storeAndSendDataToBackend(List<Coffee> cartItems) async {
    // Load SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve the user's email
    String userEmail = prefs.getString('userEmail') ?? '';

    // Prepare data to be sent to backend including the user email
    Map<String, dynamic> orderData = {
      'userEmail': userEmail,
      'items': cartItems.map((coffee) => {
        'name': coffee.name,
        'price': coffee.price,
        'imgPath': coffee.imagePath, // Update key to 'imgPath'
      }).toList(),
    };

    // Convert order data to JSON format
    String jsonData = jsonEncode(orderData);

    // Send data to backend
    final response = await http.post(
      Uri.parse('http://192.168.0.106:3000/order'),
      headers: {"Content-Type": "application/json"},
      body: jsonData,
    );

    // Handle response from backend
    if (response.statusCode == 201) {
      Provider.of<CoffeeShop>(context, listen: false).clearCart();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Order placed successfully'),
        duration: Duration(seconds: 2),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to place order'),
        duration: Duration(seconds: 2),
      ));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<CoffeeShop>(
      builder: (context, value, child) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              // Heading
              Text(
                'Your Cart',
                style: TextStyle(fontSize: 20),
              ),

              // List of cart items
              Expanded(
                child: ListView.builder(
                  itemCount: value.userCart.length,
                  itemBuilder: (context, index) {
                    // Get individual cart items
                    Coffee eachCoffee = value.userCart[index];

                    // Return coffee tile
                    return CoffeeTile(
                      coffee: eachCoffee,
                      onPressed: () => removeFromCart(eachCoffee),
                      icon: Icon(Icons.delete),
                    );
                  },
                ),
              ),

              // Button to store and send cart data to backend
              ElevatedButton(
                onPressed: () async {
                  // Retrieve cart items from CoffeeShop provider
                  List<Coffee> cartItems =
                      Provider.of<CoffeeShop>(context, listen: false).userCart;

                  // Store cart items' info and send data to backend
                  await storeAndSendDataToBackend(cartItems);
                },
                child: Text('Checkout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}