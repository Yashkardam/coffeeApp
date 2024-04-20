import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyBottomNavBar extends StatelessWidget {
  void Function(int)? onTabChange;
  MyBottomNavBar({super.key,required this.onTabChange,});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      child: GNav(
          onTabChange: (value) => onTabChange!(value),
          mainAxisAlignment: MainAxisAlignment.center,
          activeColor: Colors.brown[900],
          tabBorderRadius: 30,
          tabActiveBorder: Border.all(color:Colors.brown),
          tabs: [
            GButton(
              icon: Icons.home_filled,
              text: 'Shop',),
            GButton(
              icon: Icons.shopping_cart,
              text: 'Cart',),
            GButton(
              icon: Icons.add_box_outlined,
              text: 'Add',),
          ]
      ),
    );

  }
}
