'''import 'package:coffeapp/models/coffee_shop.dart';
import 'package:coffeapp/pages/homes_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>CoffeeShop(),
      builder: (context, child) => const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
'''
-----------------------------------------------------------------
"""
  import 'package:flutter/material.dart';
import 'coffee.dart';
import 'package:http/http.dart';
import 'dart:convert';
class CoffeeShop extends ChangeNotifier{



  // coffe for sale list
  final List<Coffee> _shop=[
    //black coffee
      Coffee(name: 'Long black', price: '4.10', imagePath: 'lib/images/black_coffee.png'),
    //latte
      Coffee(name: 'Latte', price: '4.20', imagePath: 'lib/images/latte.png'),

    //espresso
      Coffee(name: 'Espresso', price: '4.30', imagePath: 'lib/images/expresso.png'),

    //iced coffee
      Coffee(name: 'Iced Coffee', price: '4.40', imagePath: 'lib/images/iced_coffee.png'),

  ];

  //user cart
  List<Coffee> _userCart = [];

  //get coffee list
  List<Coffee> get coffeeShop => _shop;

  //get user cart
  List<Coffee> get userCart => _userCart;

  //add item to cart
  void addItemToCart(Coffee coffee){
    _userCart.add(coffee);
    notifyListeners();
  }

  //remove item from cart
  void removeItemfromCart(Coffee coffee){
    _userCart.remove(coffee);
    notifyListeners();
  }
}
"""
------------------------------------------------------------
"""
cart_page
import 'package:coffeapp/components/coffee_tile.dart';
import 'package:coffeapp/models/coffee.dart';
import 'package:coffeapp/models/coffee_shop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  //remove items from cart
  void removeFromCart(Coffee coffee){
    Provider.of<CoffeeShop>(context,listen: false).removeItemFromCart(coffee);
  }



  @override
  Widget build(BuildContext context) {
    return Consumer<CoffeeShop>(builder: (context, value, child) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              //heading
              Text('Your Cart',
                style: TextStyle(fontSize: 20),
              ),

              //list of cart items
              Expanded(child: ListView.builder(
                itemCount: value.userCart.length,
                  itemBuilder:(context, index){
                //get individual cart items
                Coffee eachCoffee = value.userCart[index];

                //return coffee tile
                return CoffeeTile(coffee: eachCoffee, onPressed:() => removeFromCart(eachCoffee), icon: Icon(Icons.delete));

              }),)

            ],

          ),
        )
    ));
  }
}

"""