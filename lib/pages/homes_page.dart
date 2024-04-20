import 'package:coffeapp/components/bottom_nav_bar.dart';
import 'package:coffeapp/constants.dart';
import 'package:coffeapp/pages/cart_page.dart';
import 'package:coffeapp/pages/shop_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:coffeapp/pages/add.dart';

class HomePage extends StatefulWidget {
  final token;
  const HomePage({@required this.token,Key? key}):super(key:key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //navigate bottom bar
  int _selectedIndex = 0;
  void navigateBottomBar(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  //pages
  final List<Widget> _pages = [
    ShopPage(),
    CartPage(),
    AddCoffeePage()
  ];

  @override
  void initState(){
    super.initState();
    Map<String,dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
