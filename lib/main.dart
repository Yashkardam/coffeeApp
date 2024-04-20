import 'package:coffeapp/models/coffee_shop.dart';
import 'package:coffeapp/pages/homes_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffeapp/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp( MyApp(token: prefs.getString('token'),));
}

class MyApp extends StatelessWidget {
  final String? token; // Make the token nullable

  const MyApp({Key? key, this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CoffeeShop(),
      builder: (context, child) => MaterialApp(
        home: (token != null && !JwtDecoder.isExpired(token!))
            ? HomePage(token: token!)
            : LoginPage(),
      ),
    );
  }
}