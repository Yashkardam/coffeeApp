import 'package:coffeapp/components/coffee_tile.dart';
import 'package:coffeapp/models/coffee_shop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffeapp/models/coffee.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {

  //add coffee to cart
  void addToCart(Coffee coffee){
    Provider.of<CoffeeShop>(context,listen: false).addItemToCart(coffee);

    //alert box
    showDialog(context: context, builder: (context)=>AlertDialog(
      title: Text("added to cart"),
    ));
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<CoffeeShop>(builder: (context, value, child) =>SafeArea(child: Column(
      children: [
        //heading msg
        const Text("How would you like your coffee?",
          style:TextStyle(fontSize: 20),),

        const SizedBox(height: 25,),

        //list of coffes to buy
        Expanded(
          child: ListView.builder(
            itemCount: value.coffeeShop.length,
            itemBuilder:(context,index){
            //get individual coffee
            Coffee eachCoffee=value.coffeeShop[index];

            //return the tile for this coffee
            return CoffeeTile(
                coffee: eachCoffee,
                icon:Icon(Icons.add) ,
                onPressed:()=>addToCart(eachCoffee),
            );

        }
        ),
        ),
      ],
    )
    ),
    );

  }
}
