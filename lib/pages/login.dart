import 'dart:convert';
import 'package:coffeapp/pages/homes_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late SharedPreferences prefs;
  void initState(){
    super.initState();
    initSharedPref();
  }
  void initSharedPref() async{
    prefs = await SharedPreferences.getInstance();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Shop Login',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );;
  }
}


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isNotValidate = false;
  late SharedPreferences prefs;
  bool loadingPrefs = true;

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      loadingPrefs = false;
    });
  }


  void loginUser() async{
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
      var reqBody = {
        "email": emailController.text,
        "password": passwordController.text
      };
      var response = await http.post(
          Uri.parse('http://192.168.0.106:3000/login'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqBody)
      );
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        var myToken = jsonResponse['token'];
        await prefs.setString('token', myToken);
        await prefs.setString('userEmail', emailController.text);  // Store the user email
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage(token: myToken)),
        );
      }else{
        print('something went wrong');
      }

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coffee Shop Login'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/images/shop_logo.jpg',
              height: 150.0,
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                errorText: _isNotValidate ? "enter proper info" : null,
                labelText: 'Email',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                errorText: _isNotValidate ? "enter proper info" : null,
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: ()=>{loginUser()},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.brown), // added style
              child: Text('Login',style: TextStyle(color: Colors.white),),
            ),
            SizedBox(height: 10.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Text('Create an account'),
            ),
          ],
        ),
      ),
    );;
  }
}


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isNotValidate = false;


    void registerUser() async {
      if (emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty) {
        var regBody = {
          "email": emailController.text,
          "password": passwordController.text
        };

        var response = await http.post(
            Uri.parse('http://192.168.0.106:3000/registration'),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(regBody)
        );
        var jsonRespone = jsonDecode(response.body);
        if (jsonRespone['status']){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginPage()));
        }else{print('something went wrong');}
      } else {
        setState(() {
          _isNotValidate = true;
        });
      }
    }


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Register'),
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  errorText: _isNotValidate ? "enter proper info" : null,
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  errorText: _isNotValidate ? "enter proper info" : null,
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () => { registerUser()},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
                // added style
                child: Text('Register', style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
      );
    }
  }
