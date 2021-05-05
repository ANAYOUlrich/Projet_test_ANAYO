import 'package:flutter/material.dart';
import 'package:tutorial_project/Home/homeScreen.dart';
import 'package:tutorial_project/Login/loginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_project/pages/regi_page.dart';
import 'package:tutorial_project/pages/login_page.dart';
import 'package:tutorial_project/pages/home_page.dart';
import 'package:tutorial_project/pages/pub.dart';
import 'package:tutorial_project/pages/publication_page.dart';
import 'package:tutorial_project/pages/create_publication.dart';
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }
  void _checkIfLoggedIn() async{
      // check if token is there
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var token = localStorage.getString('token');
      if(token!= null){
         setState(() {
            _isLoggedIn = true;
         });
      }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //body: _isLoggedIn ? Home() :  LogIn(),
        //body: _isLoggedIn ? Home() :  RegPage(),
        body: _isLoggedIn ? Home() :  LoginPage(),
        //body: _isLoggedIn ? Home() :  HomePage(),
        //body: _isLoggedIn ? Home() :  PublicationPage(),
        //body: _isLoggedIn ? Home() :  PublicationPage(),
      ),
    );
  }
}
